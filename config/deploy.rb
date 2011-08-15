$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'capistrano/ext/multistage'
set :stages, %w(testing)
set :default_stage, "testing"
set :application, "conservar"
set :repository,  "git@github.com:jmoren/conservar.git"
set :scm, :git
set :git_enable_submodules, 1
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ssh_options[:forward_agent] = true
ssh_options[:compression] = "none"

set :use_sudo, false
set :deploy_via, :remote_cache
set :branch, "testing"

namespace :deploy do
  
  task :install do
    run "cd #{current_path} && bundle install  --without=test --no-update-sources"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :web, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :single do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
