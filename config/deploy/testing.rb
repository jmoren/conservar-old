set :deploy_to, "/var/www/conservar"
set :user, "deploy"

set :rvm_ruby_string, 'ruby-1.9.2-p290'

set :rails_env, "production"
set :branch, "testing"

role :single, "banzai.dyndns-web.com"
role :app, "banzai.dyndns-web.com"
role :web, "banzai.dyndns-web.com"
role :db,  "banzai.dyndns-web.com", :primary => true
