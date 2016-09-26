require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
# require 'mina_sidekiq/tasks'

require_relative 'puma'
# require_relative 'whenever'

set :bundle_path, './bundle'

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke 'git:clone'
    invoke 'deploy:link_shared_paths'
    invoke 'bundle:install'
    invoke 'rails:assets_precompile'
    invoke 'rails:db_migrate'
    # invoke :'sidekiq:quiet'

    to :launch do
      invoke 'puma:restart'
      # invoke 'whenever:update'
      # invoke :'sidekiq:restart'
    end
  end
  invoke 'deploy:cleanup'
end

desc "Rolls back the latest release"
task rollback: :environment do
  queue! %[echo "-----> Rolling back to previous release"]

  # Delete existing sym link and create a new symlink pointing to the previous release
  queue %[echo -n "-----> Creating new symlink from the previous release: "]
  queue %[ls "#{deploy_to!}/releases" -Art | sort | tail -n 2 | head -n 1]
  queue! %[ls -Art "#{deploy_to!}/releases" | sort | tail -n 2 | head -n 1 | xargs -I active ln -nfs "#{deploy_to!}/releases/active" "#{deploy_to!}/current"]

  # Remove latest release folder (active release)
  queue %[echo -n "-----> Deleting active release: "]
  queue %[ls "#{deploy_to!}/releases" -Art | sort | tail -n 1]
  queue! %[ls "#{deploy_to!}/releases" -Art | sort | tail -n 1 | xargs -I active rm -rf "#{deploy_to!}/releases/active"]

  invoke 'puma:restart'
end
