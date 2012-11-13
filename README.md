puppet-bazinga
==============

This Puppet module contains a set of roles and some useful functions for the
following modules:

* [puppet-apache](https://github.com/puppetlabs/puppetlabs-apache)
* [puppet-apt](https://github.com/puppetlabs/puppetlabs-apt)
* [puppet-mysql](https://github.com/puppetlabs/puppetlabs-mysql)
* [puppet-php](https://github.com/saz/puppet-php)
* [puppet-rabbitmq](https://github.com/puppetlabs/puppetlabs-rabbitmq)


Installation
------------

Get the modules above, and that one by cloning it:

    git clone git://github.com/willdurand/puppet-bazinga.git modules/bazinga


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
