require './lib/mina/lib/helpers'

set :server_path, "#{deploy_to!}/server"

task :setup do
  invoke :setup_app
end

desc 'Resetup app.'
task :resetup do
  set_default :term_mode, :pretty
  # we skip default setup and invoke only our tasks
  invoke :setup_app
end

task :setup_app do
  queue! %[mkdir -p #{deploy_to!}/shared/tmp]
  queue! %[chmod g+rx,u+rwx #{deploy_to!}/shared/tmp]

  queue! %[mkdir -p #{deploy_to!}/shared/log]
  queue! %[chmod g+rx,u+rwx #{deploy_to!}/shared/log]

  queue! %[mkdir -p "#{deploy_to!}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to!}/shared/config"]

  queue! %[mkdir -p #{deploy_to!}/shared/public/uploads]
  queue! %[chmod g+rx,u+rwx #{deploy_to!}/shared/public/uploads]

  queue! %[mkdir -p "#{deploy_to!}/shared/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to!}/shared/uploads"]

  invoke :setup_services
  invoke :setup_database
  invoke :configure_application
end

task :setup_services do
  queue  %[echo "-----> Configuring services.."]

  server_path = "#{deploy_to!}/server"

  queue! %[mkdir -p #{server_path!}]

  queue  %[echo "-----> Configuring and restarting Nginx (webserver/proxy)"]
  render "lib/mina/templates/nginx-puma.erb", "#{server_path!}/nginx-puma.vhost"
  queue! %[sudo ln -sf #{server_path!}/nginx-puma.vhost /etc/nginx/sites-enabled/#{application!}]
  # queue! %[sudo service nginx restart]

  queue  %[echo "-----> Configuring Puma (appserver)"]
  render "lib/mina/templates/puma-init.erb", "#{server_path!}/puma-init.sh"
  queue! %[chmod +x #{server_path!}/puma-init.sh]
  queue! %[sudo ln -sf #{server_path!}/puma-init.sh /etc/init.d/puma-#{application!}#{suffix}]
  queue! %[sudo update-rc.d puma-#{application!}#{suffix} defaults]

  queue  %[echo "-----> Done."]
end

task :setup_database do
  queue  %[echo "-----> Setting up database.."]

  db_adapter ||= "mysql2"

  unless db_adapter.start_with?('mysql')
    print_error("Task 'setup_database' is usable ONLY WITH MYSQL! You must prepare database and user permissions manually or prepare new recipe.")
    queue  %[echo "Task 'setup_database' is usable ONLY WITH MYSQL! You must prepare database and user permissions manually or prepare new recipe."]
  else
    cmd = "CREATE DATABASE IF NOT EXISTS #{db_name!}"
    queue! %[mysql -u#{mysql_admin_user || 'root'} -p#{mysql_admin_pass!} -e '#{cmd}']

    cmd = "ALTER DATABASE #{db_name!} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci"
    queue! %[mysql -u#{mysql_admin_user || 'root'} -p#{mysql_admin_pass!} -e '#{cmd}']

    cmd = "GRANT ALL PRIVILEGES ON #{db_name!}.* TO '#{db_user!}'@localhost IDENTIFIED BY '#{db_password!}'"
    queue! %[mysql -u#{mysql_admin_user || 'root'} -p#{mysql_admin_pass!} -e "#{cmd}"]

    queue  %[echo "-----> Done."]
  end
end

task :setup_database_yml do
  render "lib/mina/templates/database.yml.erb", "#{deploy_to!}/shared/config/database.yml"
  render "lib/mina/templates/puma.rb.erb", "#{deploy_to!}/shared/config/puma.rb"
end

task :configure_application do
  invoke :setup_database_yml
end
