require 'spec_helper'


include RailsMysql
describe RailsMysql::DatabaseConfig do

  let(:database_yml) {
    {
      "development" => {
        'host' => 'HOST',
        'port' => 'PORT',
        'username' => 'USER',
        'password' => 'PASSWORD',
        "database" => "database",
      }
    }
  }
  describe '#from_yaml' do
    before { YAML.stub(:load_file) { database_yml } }
    it 'reads the yaml file' do
      DatabaseConfig.from_yaml("development")
      expect(YAML).to have_received(:load_file).with("config/database.yml")
    end

    it 'gets the correct environment settings' do
      config = DatabaseConfig.from_yaml("development")
      expect(config.host).to     eq database_yml['development']['host']
      expect(config.username).to eq database_yml['development']['username']
      expect(config.password).to eq database_yml['development']['password']
      expect(config.port).to     eq database_yml['development']['port']
      expect(config.database).to eq database_yml['development']['database']
    end
  end
end
