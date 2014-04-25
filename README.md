# RailsMysql

[![Gem Version](https://badge.fury.io/rb/rails_mysql.svg)](http://badge.fury.io/rb/rails_mysql)
[![Build Status](https://travis-ci.org/akatakritos/rails_mysql.svg?branch=master)](https://travis-ci.org/akatakritos/rails_mysql)

Provides a few simple `Rake` wrappers to mysql command line tools that read
their configuration from your Rails `database.yml`

## Installation

Add this line to your application's Gemfile:

    gem 'rails_mysql'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_mysql

## Usage

After installation into a Rails project, it provides two rake tasks for your
use.

`rake mysql:cli` will execute the `mysql` command configured for connecting to
the mysql database of your current environment

`rake mysql:dump` will execute a `mysqldump` against your configured database.
Dump files are gzipped and stored in in the `db/` folder named for the database
and timestamp.

Configurations are read from the standard `config/database.yml` file.


## Contributing

1. Fork it ( https://github.com/akatakritos/rails_mysql/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
