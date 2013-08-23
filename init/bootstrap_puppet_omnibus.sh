#!/bin/bash

OMNIBUS_PACKAGE_PATH='/vagrant/puppet-omnibus.deb'
OMNIBUS_PACKAGE_URL='https://dl.dropboxusercontent.com/u/12210925/apt/puppet-omnibus_3.1.0%2Bfpm5_amd64.deb'
APT_CACHE='/var/cache/apt/pkgcache.bin'
ONE_DAY=$(( 24 * 60 * 60 ))
OMNIBUS_PROFILE=/etc/profile.d/puppet_omnibus.sh

# update apt-cache if older than one day
if [[ ! -f $APT_CACHE || $(( $(date +%s) - $(stat -c %Z $APT_CACHE) )) -gt $ONE_DAY ]]; then
  apt-get update
fi

if [[ $(dpkg-query -W --showformat='${Status}' puppet-omnibus) != "install ok installed" ]]; then
  # download puppet-omnibus package if it's not here yet
  if [ ! -f "$OMNIBUS_PACKAGE_PATH" ]; then
    wget -q -O "$OMNIBUS_PACKAGE_PATH" "$OMNIBUS_PACKAGE_URL"
  fi

  # install dependencies
  dpkg -I $OMNIBUS_PACKAGE_PATH | grep 'Depends:' | cut -d':' -f2 | tr -d ',' | xargs apt-get install -y

  # install it!
  dpkg -i $OMNIBUS_PACKAGE_PATH
fi

# remove vagrant's puppet shim if it exists..
if [[ -f /etc/profile.d/vagrant_ruby.sh ]]; then
  rm /etc/profile.d/vagrant_ruby.sh
fi

# ...and drop our puppet in there

if [[ ! -x $OMNIBUS_PROFILE ]]; then
  echo 'PATH=$PATH:/opt/puppet-omnibus/embedded/bin' > $OMNIBUS_PROFILE
  chmod +x $OMNIBUS_PROFILE
fi
