set :output, "/root/cron.log"
# Get the environment variables from /etc/container_environment.sh
set :job_template, "bash -l -c 'source /etc/container_environment.sh ; :job'"

every 1.day, :at => '5:09 am' do
  command "/usr/local/bin/backup perform -t daily_backup"
end

every :hour do
    command "/usr/local/bin/backup perform -t hourly_backup"
end

