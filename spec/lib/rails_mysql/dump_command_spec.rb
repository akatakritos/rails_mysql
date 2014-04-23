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
      expect(Time.parse(dumper.filename[/db\/(.*?)\.sql\.gz/, 1])).to be_utc
    end
  end

end
