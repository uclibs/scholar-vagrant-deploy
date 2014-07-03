#!/bin/sh

cd /srv/apps
rm -rf curate_uc

echo "Cloning Curate_UC..."
git clone https://github.com/uclibs/curate_uc.git
cd /srv/apps/curate_uc
git checkout develop
export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin

echo "Running bundler..."
gem install --user-install bundler
bundle install --path vendor/bundle

echo "Adjusting config files..."
sed -i.bak s/ucdbdil7\.private/localhost/g /srv/apps/curate_uc/config/database.yml
sed -i.bak s/curate-devdb\.uc\.edu/data\.local\:8080/g /srv/apps/curate_uc/config/solr.yml
sed -i.bak s/curate-devdb\.uc\.edu/data\.local\:8080/g /srv/apps/curate_uc/config/fedora.yml

echo "Running database migrations..."
bundle exec rake db:migrate

echo "Starting resque pool..."
export PATH=$PATH:/opt/fits/fits-0.6.2/
./script/restart_resque.sh development
