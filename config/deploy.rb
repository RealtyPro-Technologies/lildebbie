require 'bundler/capistrano'

server "realtyproapi.com", :app, :web, :db, :primary => true

default_run_options[:pty] = true
set :application, "lildebbie"
set :repository,  "git@github.com:RealtyPro-Technologies/lildebbie.git"
#set :repository,  "git@rails.github.com:RealtyPro-Technologies/HomeFlare-Social.git"

set :scm, :git
set :branch, "master"
set :git_enable_submodules, 1

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/api/lildebbie"
set :user, "api"
set :use_sudo, false

# Load RVM's capistrano plugin.

set :rvm_type, :system
set :rvm_ruby_string, '1.9.3-p194@realtypro'

require "rvm/capistrano"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
before "deploy:restart" do
	run "ln -nfs #{shared_path}/env_vars.rb #{release_path}/config/env_vars.rb"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

desc "tail production log files" 
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err    
  end
end

desc "remotely console" 
task :console, :roles => :app do
  input = ''
  run "cd #{current_path} && ./script/console #{ENV['RAILS_ENV']}" do |channel, stream, data|
    next if data.chomp == input.chomp || data.chomp == ''
    print data
    channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
  end
end