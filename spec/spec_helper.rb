require 'rspec'
require 'active_record'
require 'shoulda-matchers'

require './lib/survey'
require './lib/question'
require './lib/response'
require './lib/q_r'
require './lib/q_s'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
    Question.all.each { |question| question.destroy }
    Response.all.each { |response| response.destroy }
  end
end
