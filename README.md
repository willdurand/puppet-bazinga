puppet-bazinga
==============

[![Build Status](https://secure.travis-ci.org/willdurand/puppet-bazinga.png?branch=master)](https://travis-ci.org/willdurand/puppet-bazinga)

This Puppet module contains a set of roles and some useful functions for the
following modules:

* [puppet-apache](https://github.com/puppetlabs/puppetlabs-apache)
* [puppet-apt](https://github.com/puppetlabs/puppetlabs-apt)
* [puppet-mysql](https://github.com/puppetlabs/puppetlabs-mysql)
* [puppet-php](https://github.com/saz/puppet-php)
* [puppet-rabbitmq](https://github.com/puppetlabs/puppetlabs-rabbitmq)
* [puppet-composer](https://github.com/willdurand/puppet-composer)


Installation
------------

Using the Puppet Module Tool, install the
[`willdurand/bazinga`](http://forge.puppetlabs.com/willdurand/bazinga)
package by running the following command:

    puppet module install willdurand/bazinga

Otherwise, clone this repository, and make sure to install the proper
dependencies.

**Important:** Version `0.0.11` is broken, do **not** use it, **never!**


Minimum Requirements
--------------------

The `bazinga::roles::base` role requires the following modules to work:

* [puppet-apt](https://github.com/puppetlabs/puppetlabs-apt)
* [puppet-ntp](https://github.com/saz/puppet-ntp)
* [stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)

Other roles need modules listed in introduction.


Installation
------------

Get the modules above, and that one by cloning it:

    git clone git://github.com/willdurand/puppet-bazinga.git modules/bazinga


The Roles
---------

This module provides a set of roles. Most of them depends on other
Puppet modules.

#### `bazinga::roles::base`

This role depends on:

* [puppet-apt](https://github.com/puppetlabs/puppetlabs-apt)
* [puppet-ntp](https://github.com/saz/puppet-ntp)

It configures APT and NTP, ensures `ssh` is present and running, installs common
tools such as `screen`, `curl`, `htop`, `ack-grep`, and `vim`, and removes
useless packages (`nfs-common`, `portmap`) on standard machines (i.e. not
Vagrant machines as Vagrant requires them).

    class { 'bazinga::roles::base':
        vagrant => true,
    }

#### `bazinga::roles::apache`

This role depends on:

* [puppet-apache](https://github.com/puppetlabs/puppetlabs-apache)

It installs Apache, enables the `rewrite` mod, and adds a new _home_ directory
for the Apache user (`/home/${user}/www`) if it is not the default one
(`www-data` for instance).

If you want to configure your own Apache user and/or group, this role will
create them:

    class { 'bazinga::roles::apache':
      apache_user  => 'foo',
      apache_group => 'bar',
    }

#### `bazinga::roles::apache_fpm`

This role depends on:

* [puppet-apache](https://github.com/puppetlabs/puppetlabs-apache)
* [puppet-php](https://github.com/saz/puppet-php)
* [puppet-composer](https://github.com/willdurand/puppet-composer)

It relies on the `bazinga::roles::apache` role.

It installs not only Apache, but also the `fastcgi` mod, enables the `actions`
and `fastcgi` mods, installs FPM, and creates a FPM pool for the Apache user.

#### `bazinga::roles::php`

This role depends on:

* [puppet-php](https://github.com/saz/puppet-php)
* [puppet-composer](https://github.com/willdurand/puppet-composer)

It installs a fully working PHP environment including the `curl`, `intl` and
`apc` extensions, and [Composer](http://getcomposer.org).

**Important:** this role does **not** install anything related to any web
server. If you want to use PHP to run web applications, use the
`bazinga::roles::apache_fpm` role in addition.

**Important:** this role does **not** install anything related to any database
vendor. If you want to use MySQL, use the `bazinga::roles::php_mysql` role
instead.


Running the tests
-----------------

Install the dependencies using [Bundler](http://gembundler.com):

    BUNDLE_GEMFILE=.gemfile bundle install

Run the following command:

    BUNDLE_GEMFILE=.gemfile bundle exec rake spec


License
-------

puppet-bazinga is released under the MIT License. See the bundled LICENSE file
for details.
