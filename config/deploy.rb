#
# Railsformers Mina Deployment Checklist
#
# ENSURE you have puma gem in Gemfile into production group
# ENSURE you have mina gem in Gemfile into development group
# ENSURE you have config/puma.rb
# ENSURE you have .ruby-version file with correct ruby version specified, which is available on the server
# ENSURE you don't have specified ruby version in Gemfile, because this is a little bit harder to maintain
#
# If you are using SSL, put your certs direct on the server into folder /etc/nginx/ssl and
#
# About suffix:

# Suffix is optional and is used for compose deploy_to, name of the unicorn init script, db_name, etc.
#
# If you're using suffix, don't forget to add _ separator on the begin, for example:
#   set :suffix, '_cs'
#
# Suffix doesn't have any impact to rails_env. If you need this, you must implement by yourself.
#


set :repository, 'git@gitlab.railsformers.com:railsformers/lora.git'

# default is staging
set :branch, 'master'
set :application, 'lora_staging'
set :nginx_vhost_domain, 'lora.staging.railsformers.com'
set :nginx_vhost_listen_ip, ''
set :rails_env, 'staging'

set :port, 2222

set :domain, rails_env!.start_with?('staging') ? 'lora.staging.railsformers.com' : 'lora.railsformers.com'

set :shared_paths, %w(
  config/database.yml
  log
  public/uploads
  tmp
)

set :db_pool, 10
set :db_user, application![0..15]
set :db_password, 'KashuxcyzKodnog'
set :db_name, "#{application}#{env_suffix}"

#set :mysql_admin_pass, rails_env.start_with?('staging') ? ENV['MYSQL_ROOT_PASSWORD_STAGING'] : ENV['MYSQL_ROOT_PASSWORD_NIBELUNG']

set :nginx_proxy_read_timeout, 720

# ---

set :user, 'deployer'

set :deploy_to, "/var/www/#{user}/#{fetch(:application)}#{env_suffix}"

set :server_path, "#{fetch(:deploy_to)}/server"

task :environment do
  invoke 'rbenv:load'
end

# load recipes
require_relative '../lib/mina/recipes/setup'
require_relative '../lib/mina/recipes/deploy'
