require 'active_record'

require './lib/survey'
require './lib/question'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

def welcome
  puts "Welcome to the Survey Maker 2000!"
  main_menu
end

def main_menu
  choice = nil
  until choice == 'x'
    puts "Enter 's' to add a new survey."
    puts "      'q' to go to question manager"
    puts "      'x' to exit."
    choice = gets.chomp
    case choice
    when 's'
      add_survey
    when 'q'
      question_manager
    when 'x'
      puts "Goodbye!"
    else
      puts "Invalid entry, please try again."
    end
  end
end

def add_survey
  puts "Name the survey:"
  new_name = gets.chomp
  new_survey = Survey.create({name: new_name})
  puts "New survey named '#{new_name}' created!"
end


def question_manager
  puts "Enter sentence for the question to be added:"
  new_description = gets.chomp
  new_q = Question.create({description: new_description})
  puts "'#{new_description}' was added."
end




system "clear && printf '\e[3J'"
welcome
