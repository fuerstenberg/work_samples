# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'cms'
set :repo_url, 'git@github.com:____Systems/____-cms-v2.git'
set :deploy_to, "/srv/cms"
set :branch, :master

# RVM settings
# set :rvm_type, :user  # Defaults to: :auto
# set :rvm_ruby_version, 'ruby-2.3.0@____2'      # Defaults to: 'default'

# Bundler settings
set :bundle_binstubs, -> { shared_path.join('bin') }

set :linked_files, %w{config/mongoid.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/assets uploads vendor/bundle}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 20
set :passenger_restart_with_touch, true

set :rvm_type, :user                # Defaults to: :auto
set :rvm_ruby_version, '2.4.4@____2' # Defaults to: 'default'
set :rvm_custom_path, '~/.rvm'      # only needed if not detected
