set :application, "WMCourier"
set :repository,  "http://dev.wm.ru/svn/wmcourier/trunk"
set :scm_username, "dfr"
set :scm_password, "svn"
set :checkout, "export"
set :user, "www"

set :use_sudo, false

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

default_run_options[:pty] = true

set :deploy_to, "/usr/local/www/rails/#{application}"

set :domain, "vds5.wm.ru"
role :web, domain
role :app, domain
role :db,  domain, :primary => true
