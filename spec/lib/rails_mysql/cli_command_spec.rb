require 'spec_helper'

describe RailsMysql::CliCommand do
  describe 'command' do
    before { Kernel.stub(:exec) }
    let(:command) { RailsMysql::CliCommand.new(config) }
    let(:config) { double(:host => "HOST",
                         :username => "USERNAME",
                         :password => "PASSWORD",
                         :port => "PORT",
                         :database => "DATABASE") }

    def cli_without(*args)
      args.each do |arg|
        config.stub(arg) { nil }
      end
      RailsMysql::CliCommand.new(config)
    end

    it 'Kernel.execs the correct parameters' do
      expect(command.command).to eq(%Q{mysql -h"HOST" -u"USERNAME" -p"PASSWORD" -P"PORT" -D"DATABASE"})
    end

    describe 'optional configurations' do
      it 'allows host to be optional' do
        expect(cli_without(:host).command).to_not include("-h")
      end
      it 'allows username to be optional' do
        expect(cli_without(:username).command).to_not include("-u")
      end
      
      it 'allows port to be optional' do
        expect(cli_without(:port).command).to_not include("-P")
      end
      
      it 'allows database to be optional' do
        expect(cli_without(:database).command).to_not include("-D")
      end

      it 'executes just mysql with no options' do
        expect(cli_without(
          :database,
          :username,
          :password,
          :port,
          :host).command).to eq "mysql"
      end
      
    end
  end
end

