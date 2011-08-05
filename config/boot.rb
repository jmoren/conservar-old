require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

app_config = File.join(File.expand_path('../../config', __FILE__), 'app_config.yml')
if File.exist?(app_config)
  CONFIG = YAML.load_file(app_config)
else
  CONFIG={}
end

