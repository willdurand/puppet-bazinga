#!/usr/bin/env bash
#
# MIT License - William Durand <william.durand1@gmail.com>
#
# This script can be used to initialize a Vagrant VM
# to avoid weird errors due to a random Puppet version.
#
# Usage:
#
#   ./bootstrap.sh [--distribution <distribution name>] [--version <puppet version>]
#

set -e

if [ "2" -eq "$#" ] && [ "--distribution" == "$1" ] ; then
    DISTRIBUTION="$2"
fi

if [ "2" -eq "$#" ] && [ "--version" == "$1" ] ; then
    PUPPET_VERSION="$2"
fi

if [ "4" -eq "$#" ] && [ "--distribution" == "$1" ] ; then
    DISTRIBUTION="$2"
fi

if [ "4" -eq "$#" ] && [ "--version" == "$1" ] ; then
    PUPPET_VERSION="$2"
fi

if [ "4" -eq "$#" ] && [ "--distribution" == "$3" ] ; then
    DISTRIBUTION="$4"
fi

if [ "4" -eq "$#" ] && [ "--version" == "$3" ] ; then
    PUPPET_VERSION="$4"
fi

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

echo "Installing Puppet version $PUPPET_VERSION for $DISTRIBUTION..."

wget -q http://apt.puppetlabs.com/puppetlabs-release-$DISTRIBUTION.deb
sudo dpkg -i puppetlabs-release-$DISTRIBUTION.deb > /dev/null
rm -f puppetlabs-release-$DISTRIBUTION.deb
sudo apt-get update > /dev/null
sudo apt-get -y --force-yes install puppet-common=$PUPPET_VERSION-1puppetlabs1 > /dev/null
sudo apt-get -y --force-yes install puppet=$PUPPET_VERSION-1puppetlabs1 > /dev/null

if [ 0 -eq $? ] ; then
    echo "Puppet $PUPPET_VERSION successfully installed"
fi
