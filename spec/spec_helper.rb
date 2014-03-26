require 'rspec'
require 'active_record'

require './lib/survey'
require './lib/question'
require './lib/response'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
  end
end
