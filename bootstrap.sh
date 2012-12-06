#!/usr/bin/env bash
#
# This script can be used to initialize a Vagrant VM
# to avoid weird errors due to a random Puppet version.

if [ -z "$PUPPET_VERSION" ]; then
    PUPPET_VERSION='2.7.20'
fi

# See: http://apt.puppetlabs.com/
if [ -z "$DISTRIBUTION" ]; then
    DISTRIBUTION='squeeze'
fi

if [ `puppet --version` == $PUPPET_VERSION ] ; then
    exit 0
fi

wget http://apt.puppetlabs.com/puppetlabs-release-$DISTRIBUTION.deb
sudo dpkg -i puppetlabs-release-$DISTRIBUTION.deb
rm -f puppetlabs-release-$DISTRIBUTION.deb
sudo apt-get update
sudo apt-get -y --force-yes install puppet-common=$PUPPET_VERSION-1puppetlabs2
sudo apt-get -y --force-yes install puppet=$PUPPET_VERSION-1puppetlabs2
