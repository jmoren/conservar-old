$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'capistrano/ext/multistage'
set :stages, %w(testing)
set :default_stage, "testing"
set :application, "conservar"
set :repository,  "git@github.com:jmoren/conservar.git"
set :scm, :git

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

ssh_options[:forward_agent] = true
ssh_options[:compression] = "none"

set :use_sudo, false
set :deploy_via, :remote_cache
set :branch, "testing"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :web, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :single do
    run "cd #{release_path} && whenever  --update-crontab #{application}"
  end

  after 'deploy:finalize_update' do
    run "cd #{release_path}; bundle install --without development test"
  end

  before 'deploy:migrate', :roles => :app do
    symlinks
  end

  desc "Clears the chached-copy allowing submodule updates"
  task :clear_cached_copy do
    run <<-CMD
    rm -rf #{shared_path}/cached-copy
    CMD
  end

  desc "Apunta los archivos de configuracion"
  task :symlinks do
    %w(database.yml app_config.yml).each do|yaml|
      run "ln -sf #{deploy_to}/shared/config/#{yaml} #{release_path}/config/#{yaml}"
    end
  end
end

