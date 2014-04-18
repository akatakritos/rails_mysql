require 'spec_helper'

describe RailsMysql::CliCommand do
  describe 'exec' do
    before { Kernel.stub(:exec) }
    let(:command) { RailsMysql::CliCommand.new(config) }
    let(:config) { double(:host => "HOST",
                         :username => "USERNAME",
                         :password => "PASSWORD",
                         :port => "PORT",
                         :database => "DATABASE") }
    it 'Kernel.execs the correct parameters' do
      command.execute
      expect(Kernel).to have_received(:exec).with(%Q{mysql -h"HOST" -u"USERNAME" -p"PASSWORD" -P"PORT" -D"DATABASE"})
    end
  end
end

