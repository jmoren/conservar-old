set :deploy_to, "/var/www/conservar"

set :user, "jmoren"

set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
set :rvm_bin_path, "/home/jmoren/.rvm/bin"
set :rails_env, "production"
set :branch, "testing"

role :single, "banzai.dyndns-web.com"
role :app, "banzai.dyndns-web.com"
role :web, "banzai.dyndns-web.com"
role :db,  "banzai.dyndns-web.com", :primary => true

after "deploy:finalize_update", "deploy:symlinks"
afet "deploy:finalize_update", "deploy:update_crontab"

