#!/usr/bin/env bash

sudo locale-gen zh_TW.UTF-8
sudo cp /etc/apt/sources.list /etc/apt/sources.list.cp
sudo sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y git git-flow
sudo apt-get install -y mysql-common mysql-client libmysqlclient-dev

# Add for mysql server
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 12345678'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 12345678'
sudo apt-get install -y mysql-server

su - vagrant -c  'cd /home/vagrant'
su - vagrant -c  'curl -sSL https://rvm.io/mpapis.asc | gpg --import -'
su - vagrant -c  'curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.2'
su - vagrant -c  'source /home/vagrant/.rvm/scripts/rvm'
su - vagrant -c  'gem install bundler'

# # pcloud custom
sudo apt-get install -y imagemagick libmagickwand-dev qt5-default libqt5webkit5-dev nodejs redis-server xvfb

# Treasure Data
su - vagrant -c 'sudo curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh'

# Bot fluentd
sudo cp /vagrant/td-agent.conf /etc/td-agent

# mongooseim 1.5.0
su - vagrant -c 'sudo cp -r /vagrant/xmpp /home/vagrant'
su - vagrant -c 'wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb'
su - vagrant -c 'sudo dpkg -i erlang-solutions_1.0_all.deb'
su - vagrant -c 'sudo apt-get update'
su - vagrant -c 'wget http://packages.erlang-solutions.com/site/esl/mongooseim/FLAVOUR_1_main/mongooseim_1.5.0-1~ubuntu~trusty_amd64.deb'
su - vagrant -c 'sudo apt-get install -y libodbc1'
su - vagrant -c 'sudo apt-get install -y unixodbc'
su - vagrant -c 'sudo dpkg -i mongooseim_1.5.0-1~ubuntu~trusty_amd64.deb'


# Create mongooseim database and data
cd /home/vagrant/xmpp/xmpp_sql
cat mysql.sql create_xmpp_data.sql > mongooseim.sql
sudo mysql -uroot -p12345678 < /home/vagrant/xmpp/xmpp_sql/mongooseim.sql


# Install mongooseim onetime-password-module
cd /home/vagrant/xmpp/xmpp_module/onetime-password
sudo apt-get install -y erlang-base
sudo apt-get install -y erlang-base-hipe
erlc mod_onetime_password.erl
sudo cp mod_onetime_password.beam /usr/lib/mongooseim/lib/ejabberd-2.1.8+mim-1.5.0/ebin/
sudo rm -rf mod_onetime_password.beam


# Replace mongooseim config
cd /home/vagrant/xmpp/xmpp_config
sudo cp ejabberd.cfg /usr/lib/mongooseim/etc/


# Restart mongooseim
sudo service mongooseim restart




