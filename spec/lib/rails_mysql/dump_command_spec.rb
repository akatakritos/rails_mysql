require 'spec_helper'
require 'optparse'

def parse_options(cmd)
  splitted_cmd = cmd.shellsplit
  options = {}
  OptionParser.new do |opts|
    opts.on("-h host") { |h| options[:host] = h }
    opts.on("-u username") { |u| options[:username] = u }
    opts.on("-p password") { |p| options[:password] = p }
    opts.on("-P port") { |p| options[:port] = p }
  end.parse!(splitted_cmd)
  
  options[:cmd] = splitted_cmd.first
  options[:args] = splitted_cmd[1..-1]
  options
end
describe RailsMysql::DumpCommand do
  let(:config) {
    double(
      :host => "HOST",
      :database => "DATABASE",
      :username => "USERNAME",
      :password => "PASSWORD",
      :port => "PORT")
  }


  it 'returns mysqldump with the right params' do
    cmd = RailsMysql::DumpCommand.new(config).command

    options = parse_options(cmd[/^[^\|]+/])
    expect(options[:cmd]).to      eq "mysqldump"
    expect(options[:host]).to     eq config.host
    expect(options[:port]).to     eq config.port
    expect(options[:username]).to eq config.username
    expect(options[:password]).to eq config.password
    expect(options[:args]).to     eq [config.database]

  end

  it 'pipes through gzip' do
    cmd = RailsMysql::DumpCommand.new(config).command
    expect(cmd).to match(/\|\s+gzip\s+>.*$/)
  end

  it 'cats out to its filename' do
    dumper = RailsMysql::DumpCommand.new(config)
    cmd = dumper.command
    expect(cmd).to match(/\s>\s+#{Regexp.escape(dumper.filename)}$/)

  end

  describe 'filename' do
    let(:dumper) { RailsMysql::DumpCommand.new(config) }
    it 'is in the db folder' do
      expect(dumper.filename).to start_with("db/")
    end

    it 'is a parsable time' do
      expect{Time.parse(dumper.filename[/db\/(.*?)\.sql\.gz/, 1])}.to_not raise_error
    end

    it 'ends in .sql.gz' do
      expect(dumper.filename).to end_with(".sql.gz")
    end

    it 'is in utc' do
      expect(Time.parse(dumper.filename[/db\/(.*?)\.sql\.gz/, 1])).to be_utc
    end
  end

end
