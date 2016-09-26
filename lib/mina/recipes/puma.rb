namespace :puma do

  task :start do
    queue "sudo /etc/init.d/puma-#{application!} start"
  end

  task :stop do
    queue "sudo /etc/init.d/puma-#{application!} stop"
  end

  task :restart do
    queue "sudo /etc/init.d/puma-#{application!} restart"
  end

  task :reload do
    queue "sudo /etc/init.d/puma-#{application!} reload"
  end

  task :upgrade do
    queue "sudo /etc/init.d/puma-#{application!} upgrade"
  end

end
