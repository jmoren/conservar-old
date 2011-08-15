job_type :bundle_exec_rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.day, :at => "8am"  do
  bundle_exec_rake "alerts:send"
end
#
# every 4.days do
#   runner ", :at => "1am" doAnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
