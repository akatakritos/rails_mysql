# RailsMysql

TODO: Write a gem description

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

`rake mysql:cli` will execute the command line cli program connecting to 
the mysql database for your current environment

`rake mysql:dump` will execute a mysqldump against your configured database.
Dump files are gzipped and stored in in the db/ folder.

Configurations are read from the standard `config/database.yml' file.


## Contributing

1. Fork it ( https://github.com/akatakritos/rails_mysql/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
