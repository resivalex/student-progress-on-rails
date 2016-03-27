# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'student_progress'
set :repo_url, 'git@github.com:resivalex/student-progress-on-rails.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, :develop

# Default deploy_to directory is /var/www/student_progress
set :deploy_to, '/var/www/student_progress'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false

set :rails_env, 'production'

set :bundle_flags, '--deployment'

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :tmp_dir, '/tmp'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :deploy do
  desc "Start the Unicorn process when it isn't already running."
  task :start do
    on roles :all do
      execute :cd, "#{current_path} && #{current_path}/bin/unicorn -Dc #{current_path}/config/unicorn.rb -E #{fetch :rails_env}"
    end
  end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
  task :restart do
    on roles :all do
      execute :kill, "-USR2 $(cat #{shared_path}/unicorn.pid)"
    end
  end

  desc "Stop the application by killing the Unicorn process"
  task :stop do
    on roles :all do
      execute :kill, "$(cat #{shared_path}/unicorn.pid)"
    end
  end
end
