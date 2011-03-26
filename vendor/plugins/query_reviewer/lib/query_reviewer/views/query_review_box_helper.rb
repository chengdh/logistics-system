module QueryReviewer
  module Views
    module QueryReviewBoxHelper
      def parent_div_class
        "sql_#{parent_div_status.downcase}"
      end

      def parent_div_status
        if !enabled_by_cookie
          "DISABLED"
        elsif overall_max_severity < (QueryReviewer::CONFIGURATION["warn_severity"] || 4)
          "OK"
        elsif overall_max_severity < (QueryReviewer::CONFIGURATION["critical_severity"] || 7)
          # uh oh
          "WARNING"
        else
          # oh @#&!
          "CRITICAL"
        end
      end

      def syntax_highlighted_sql(sql)
        if QueryReviewer::CONFIGURATION["uv"]
          uv_out = Uv.parse(sql, "xhtml", "sql_rails", false, "blackboard")
          uv_out.gsub("<pre class=\"blackboard\">", "<code class=\"sql\">").gsub("</pre>", "</code>")
        else
          sql.gsub(/</, "&lt;").gsub(/>/, "&gt;")
        end
      end

      def overall_max_severity
        max = 0
        max = queries_with_warnings_sorted_nonignored[0].max_severity unless queries_with_warnings_sorted_nonignored.empty?
        max = warnings_no_query_sorted.first.severity unless warnings_no_query_sorted.empty? || warnings_no_query_sorted.first.severity < max
        max
      end

      def severity_color(severity)
        red = (severity * 16.0 / 10).to_i
        green = ((10-severity) * 16.0 / 10).to_i
        red = 8 if red > 8
        red = 0 if red < 0
        green = 8 if green > 8
        green = 0 if green < 0
        "##{red.to_s(16)}#{green.to_s(16)}0"
      end

      def ignore_hash?(h)
        (controller.send(:cookies)["query_review_ignore_list"] || "").split(",").include?(h.to_s)
      end

      def queries_with_warnings
        @queries.queries.select{|q| q.has_warnings?}
      end

      def queries_with_warnings_sorted
        queries_with_warnings.sort{|a,b| (b.max_severity * 1000 + (b.duration || 0)) <=> (a.max_severity * 1000 + (a.duration || 0))}
      end

      def queries_with_warnings_sorted_nonignored
        queries_with_warnings_sorted.select{|q| q.max_severity >= ::QueryReviewer::CONFIGURATION["warn_severity"] && !ignore_hash?(q.to_hash)}
      end

      def queries_with_warnings_sorted_ignored
        queries_with_warnings_sorted.reject{|q| q.max_severity >= ::QueryReviewer::CONFIGURATION["warn_severity"] && !ignore_hash?(q.to_hash)}
      end

      def warnings_no_query_sorted
        @queries.collection_warnings.sort{|a,b| a.severity <=> b.severity}.reverse
      end

      def warnings_no_query_sorted_ignored
        warnings_no_query_sorted.select{|q| q.severity < ::QueryReviewer::CONFIGURATION["warn_severity"]}
      end

      def warnings_no_query_sorted_nonignored
        warnings_no_query_sorted.select{|q| q.severity >= ::QueryReviewer::CONFIGURATION["warn_severity"]}
      end

      def enabled_by_cookie
        controller.send(:cookies)["query_review_enabled"]
      end

      def duration_with_color(query)
        title = query.duration_stats
        duration = query.duration
        if duration > QueryReviewer::CONFIGURATION["critical_duration_threshold"]
          "<span style=\"color: #{severity_color(9)}\" title=\"#{title}\">#{"%.3f" % duration}</span>".html_safe
        elsif duration > QueryReviewer::CONFIGURATION["warn_duration_threshold"]
          "<span style=\"color: #{severity_color(QueryReviewer::CONFIGURATION["critical_severity"])}\" title=\"#{title}\">#{"%.3f" % duration}</span>".html_safe
        else
          "<span title=\"#{title}\">#{"%.3f" % duration}</span>".html_safe
        end
      end
      
      EXPLN_COLUMNS = {
        :table => "table", :select_type => 'select type', :query_type => 'type', :extra => 'extra',
        :possible_keys => 'possible keys', :key => "key", :key_len => "key length",
        :ref => "ref", :rows => "rows"
      }
      
      def format_column(value, column, data)
        column_widths = data.map{|sq| sq.send(column.to_sym).to_s.length}
        column_widths << EXPLN_COLUMNS[column].length
        max_width = column_widths.max
        "%-#{max_width}s" % value
      end
      
      def text_row(subquery, subqueries)
        row = []
        row << format_column(subquery.table, :table, subqueries)
        row << format_column(subquery.select_type, :select_type, subqueries)
        row << format_column(subquery.query_type, :query_type, subqueries)
        row << format_column(subquery.extra, :extra, subqueries)
        row << format_column(subquery.possible_keys, :possible_keys, subqueries)
        row << format_column(subquery.key, :key, subqueries)
        row << format_column(subquery.key_len, :key_len, subqueries)
        row << format_column(subquery.ref, :ref, subqueries)
        row << format_column(subquery.rows, :rows, subqueries)
        text = row.join(' | ')
        return "   | #{text} |"
      end
      
      def subqueires_table(subqueries)
        rows = []
        hrow = []
        hrow << format_column(EXPLN_COLUMNS[:table], :table, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:select_type], :select_type, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:query_type], :query_type, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:table], :extra, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:possible_keys], :possible_keys, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:key], :key, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:key_len], :key_len, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:ref], :ref, subqueries)
        hrow << format_column(EXPLN_COLUMNS[:rows], :rows, subqueries)
        header = hrow.join(' | ')
        rows << "   | #{header} |"
        
        subqueries.each do |subquery|
          rows << text_row(subquery, subqueries)
        end
        
        rows.join("\n")
      end
    end
  end
end
