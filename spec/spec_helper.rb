require 'rails_mysql'
require 'rake'

def parse_options(cmd)
  splitted_cmd = cmd.shellsplit
  options = {}
  OptionParser.new do |opts|
    opts.on("-h host")     { |h| options["-h"] = h }
    opts.on("-u username") { |u| options["-u"] = u }
    opts.on("-p password") { |p| options["-p"] = p }
    opts.on("-P port")     { |p| options["-P"] = p }
    opts.on("-D database") { |d| options["-D"] = d }
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

