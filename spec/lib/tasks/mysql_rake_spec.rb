require 'spec_helper'
require 'rails'

def rake_path
  [File.expand_path(File.join(%W{ lib tasks }))]
end

def rake(task)
  Rake.application[task].invoke
end

def fixture_path(fixture)
  File.expand_path(File.dirname(__FILE__) + "../../../fixtures/#{fixture}")
end

def with_fixture(fixture)
  old_path = Dir.pwd
  Dir.chdir fixture_path(fixture)
  yield
ensure
  Dir.chdir old_path
end


describe 'rake tasks' do

  before(:all) do
    Rake.application = Rake::Application.new
    Rake.application.rake_require 'mysql', rake_path
  end

  describe 'rake mysql:cli' do
    before { RakeFileUtils.stub(:sh) }
    before { Rails.stub(:env) { "development" } }

    it 'calls exec with the correct params' do
      with_fixture("default") do
        rake 'mysql:cli'
      end

      expect(RakeFileUtils).to have_received(:sh).with("mysql -h\"HOST\" -u\"USER\" -p\"PASSWORD\" -P\"PORT\" -D\"DATABASE\"");

    end
  end

  describe 'rake mysql:dump' do
    before { RakeFileUtils.stub(:sh) }
    before { Rails.stub(:env) { "development" } }

    it 'calls exec with the correct params' do

      expect(RakeFileUtils).to receive(:sh) do |cmd|
        expect(cmd).to match(/^mysqldump\b/)
        expect(cmd).to match(/-h\s+"HOST"/)
        expect(cmd).to match(/-u\s+"USER"/)
        expect(cmd).to match(/-p\s+"PASSWORD"/)
        expect(cmd).to match(/-P\s+"PORT"/)
        expect(cmd).to match(/|\s+>\s+.*/) # cats to some file
      end

      with_fixture("default") do
        rake 'mysql:dump'
      end

    end
  end
end
