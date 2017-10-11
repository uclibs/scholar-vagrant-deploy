#!/bin/sh

cd /srv/apps
rm -rf curate_uc

echo "Cloning Scholar_UC..."
git clone https://github.com/uclibs/scholar_uc.git curate_uc
cd /srv/apps/curate_uc
git checkout vagrant

mkdir tmp
chmod +x script/*.sh
./script/copy_config_local.sh

echo "Running bundler..."
export PATH=$PATH:/srv/apps/.gem/ruby/2.4.0/bin
gem install --user-install bundler
bundle install --path vendor/bundle

echo "Running database migrations..."
bundle exec rake db:migrate

echo "Starting Sidekiq..."
./script/restart_sidekiq.sh development

export PATH=$PATH:/opt/fits/fits-0.8.5/
touch tmp/restart.txt

