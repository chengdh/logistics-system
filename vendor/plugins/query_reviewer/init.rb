# Include hook code here

require 'query_reviewer'

if QueryReviewer.enabled?
  ActiveRecord::Base
  adapter_class = ActiveRecord::ConnectionAdapters::MysqlAdapter  if defined? ActiveRecord::ConnectionAdapters::MysqlAdapter
  adapter_class = ActiveRecord::ConnectionAdapters::Mysql2Adapter if defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter
  adapter_class.send(:include, QueryReviewer::MysqlAdapterExtensions)
  ActionController::Base.send(:include, QueryReviewer::ControllerExtensions)
  Array.send(:include, QueryReviewer::ArrayExtensions)
  
  if ActionController::Base.respond_to?(:append_view_path)
    ActionController::Base.append_view_path(File.dirname(__FILE__) + "/lib/query_reviewer/views")
  end
end
