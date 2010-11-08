source 'http://rubygems.org'

gem 'rails', '3.0.1'
gem 'mysql2'
gem "will_paginate", "~> 3.0.pre2"
gem "meta_search"
#表单中的树形结构选择
gem 'acts_as_tree',:git => 'git://github.com/parasew/acts_as_tree.git'
gem 'tree_select', :git => 'git://github.com/jeznet/tree_select.git'
#客户端验证框架,需要使用到jquery
gem 'client_side_validations'
#form 显示组件
gem 'formtastic', '~>1.1.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
group :development do
  gem 'rspec-rails','2.0.1'
  gem 'annotate-models', '1.0.4'
  gem 'jquery-rails'
end
group :development, :test do
    gem 'web-app-theme', '>= 0.6.2'
end
group :test do
  gem 'rspec','2.0.1'
  gem 'factory_girl_rails', '1.0'
  gem 'faker'
  #gem 'webrat'
end
