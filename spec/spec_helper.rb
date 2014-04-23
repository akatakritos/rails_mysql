require 'rails_mysql'
require 'rake'

def parse_options(cmd)
  splitted_cmd = cmd.shellsplit
  options = {}
  OptionParser.new do |opts|
    opts.on("-h host")     { |h| options[:host]     = h }
    opts.on("-u username") { |u| options[:username] = u }
    opts.on("-p password") { |p| options[:password] = p }
    opts.on("-P port")     { |p| options[:port]     = p }
    opts.on("-D database") { |d| options[:database] = d }
  end.parse!(splitted_cmd)

  options[:cmd]  = splitted_cmd.first
  options[:args] = splitted_cmd[1..-1]
  options
end

##
# expect(command).to pipe_to "gzip"
#   => asserts that command has basically "| gzip " in it somewhere
RSpec::Matchers.define :pipe_to do |command|
  match do |actual|
    actual.match /\|\s*#{Regexp.quote(command)}\b/
  end
end

