namespace :whenever do

  desc "Clear crontab"
  task :clear do
    queue %{
      echo "-----> Clear crontab for #{application}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; bundle exec whenever --clear-crontab #{application}_#{rails_env} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end

  desc "Update crontab"
  task :update do
    queue %{
      echo "-----> Update crontab for #{application}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; bundle exec whenever --update-crontab #{application}_#{rails_env} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end

  desc "Write crontab"
  task :write do
    queue %{
      echo "-----> Update crontab for #{application}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; bundle exec whenever --write-crontab #{application}_#{rails_env} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}']}
    }
  end

end
