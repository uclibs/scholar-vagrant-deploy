#!/bin/sh

cd /srv/apps
rm -rf curate_uc

echo "Cloning Curate_UC..."
git clone https://github.com/uclibs/curate_uc.git
cd /srv/apps/curate_uc
git checkout vagrant

echo "Running bundler..."
export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin
gem install --user-install bundler
bundle install --path vendor/bundle

echo "Running database migrations..."
bundle exec rake db:migrate

echo "Starting resque pool..."
export PATH=$PATH:/opt/fits/fits-0.6.2/
chmod +x /srv/apps/curate_uc/script/restart_resque.sh
./script/restart_resque.sh development
