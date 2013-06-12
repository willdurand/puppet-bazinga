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
