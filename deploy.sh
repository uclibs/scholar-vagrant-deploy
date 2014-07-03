#!/bin/sh

cd /srv/apps
rm -rf curate_uc
git clone https://github.com/uclibs/curate_uc.git
cd /srv/apps/curate_uc
git checkout develop
export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin
gem install --user-install bundler
bundle install --path vendor/bundle
sed -i.bak s/ucdbdil7\.private/localhost/g /srv/apps/curate_uc/config/database.yml
sed -i.bak s/curate-devdb\.uc\.edu/data\.local\:8080/g /srv/apps/curate_uc/config/solr.yml
sed -i.bak s/curate-devdb\.uc\.edu/data\.local\:8080/g /srv/apps/curate_uc/config/fedora.yml
bundle exec rake db:migrate

