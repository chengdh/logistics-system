#add bundler support
require 'bundler/capistrano'
set :application, "il_yanzhao"
set :repository,  "git://github.com/chengdh/il_yanzhao.git"
#set :repository,  "file:///media/WORK/il_yanzhao/.git/"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
server "192.168.1.199",:app,:web,:db,:primary => true

set :user,"root"
set :use_sudo,false
default_run_options[:pty]=true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
