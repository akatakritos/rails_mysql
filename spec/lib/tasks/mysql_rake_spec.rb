require 'spec_helper'
require 'rails'

def rake_path
  [File.join(%W{ lib tasks })]
end

def rake(task)
  Rake.application[task].invoke
end

def with_fixture(fixture)
  old_path = Dir.pwd
  Dir.chdir "spec/fixtures/#{fixture}"
  yield
ensure
  Dir.chdir old_path
end


describe 'rake tasks' do
  let(:rake_app) { Rake::Application.new }

  before do
    Rake.application = rake_app
    Rake.application.rake_require 'mysql', rake_path
  end

  describe 'rake mysql:cli' do
    before { Kernel.stub(:exec) }
    before { Rails.stub(:env) { "development" } }

    it 'calls exec with the correct params' do
      with_fixture("default") do
        rake 'mysql:cli'
        expect(Kernel).to have_received(:exec).with("mysql -h\"HOST\" -u\"USER\" -p\"PASSWORD\" -P\"PORT\" -D\"DATABASE\"");
      end
    end
  end
end
