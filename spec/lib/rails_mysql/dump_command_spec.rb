require 'spec_helper'
require 'optparse'

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
    expect(options[:cmd]).to  eq "mysqldump"
    expect(options["-h"]).to  eq config.host
    expect(options["-P"]).to  eq config.port
    expect(options["-u"]).to  eq config.username
    expect(options["-p"]).to  eq config.password
    expect(options[:args]).to eq [config.database]

  end

  it 'doesnt have a space between -p and the password' do
    cmd = described_class.new(config).command
    expect(cmd).to_not match "\s-p\s"
  end

  def dump_without(*args)
    args.each do |arg|
      config.stub(arg){ nil }
    end
    RailsMysql::DumpCommand.new(config)
  end

  describe 'optional arguments' do
    it 'doesnt require host' do
      expect(dump_without(:host).command).to_not include "-h"
    end

    it 'doesnt require username' do
      expect(dump_without(:username).command).to_not include "-u"
    end

    it 'doesnt require password' do
      expect(dump_without(:password).command).to_not include "-p"
    end

    it 'doesnt require port' do
      expect(dump_without(:port).command).to_not include "-P"
    end
  end

  it 'throws when it doesnt have a database' do
    conf = double(:database => nil)
    expect{ RailsMysql::DumpCommand.new(conf) }.to raise_error(RailsMysql::ConfigurationError)
  end

  it 'pipes through gzip' do
    cmd = RailsMysql::DumpCommand.new(config).command
    expect(cmd).to pipe_to("gzip")
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
      expect(Time.parse(dumper.filename[/db\/.*-(.*?)\.sql\.gz/, 1])).to be_utc
    end

    it 'has the db name' do
      expect(dumper.filename).to include "DATABASE"
    end
  end

end
