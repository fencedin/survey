require 'active_record'
require 'pry'

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
    puts "Enter 's' to go to survey manager."
    puts "      'q' to go to question manager"
    puts "      'r' to go to response manager"
    puts "      'x' to exit."
    choice = gets.chomp
    case choice
    when 's'
      clear
      survey_manager
    when 'q'
      clear
      question_manager
    when 'r'
      clear
      response_manager
    when 'x'
      clear
      puts "Goodbye!"
      exit
    else
      clear
      puts "Invalid entry, please try again."
    end
  end
end

# SURVEY =============================================
def survey_manager
  choice = nil
  until choice == 'b'
    puts "Enter 'l' to list all surveys"
    puts "      'a' to add a new survey"
    puts "      'e' to edit an existing survey"
    puts "      'd' to delete a survey"
    puts "      'b' to go back."
    choice = gets.chomp
    case choice
    when 'l'
      clear
      list_survey
    when 'a'
      add_survey
    when 'e'
      list_survey
      edit_survey
    when 'd'
      list_survey
      delete_survey
    when 'b'
      clear
      main_menu
    else
      clear
      puts "Invalid entry, please try again."
    end
  end
end

def list_survey
  puts "Here is a list of all surveys:"
  puts "=============================="
  Survey.all.each {|survey| puts survey.name}
  puts "=============================="
end

def add_survey
  puts "Name the survey:"
  new_name = gets.chomp

  new_survey = Survey.new({name: new_name})
  clear
  if new_survey.save
    puts "New survey named '#{new_name}' created!"
  else
    new_survey.errors.full_messages.each { |message| puts message }
  end
end

def edit_survey
  puts "Enter name of survey you wish to edit:"
  edit_choice = gets.chomp
  puts "Renamed to:"
  new_name = gets.chomp
  survey =  Survey.where({name: edit_choice}).first
  survey.update({name: new_name})
  clear
  puts "'#{edit_choice}' was changed to '#{new_name}'"
end

def delete_survey
  puts "Enter name of survey you wish to delete:"
  edit_choice = gets.chomp
  survey =  Survey.where({name: edit_choice}).first
  survey.destroy
  clear
  puts "'#{edit_choice}' has been deleted!"
end


# QUESTION ============================================

def question_manager
  puts "Enter sentence for the question to be added:"
  new_description = gets.chomp
  new_q = Question.create({description: new_description})
  puts "'#{new_description}' was added."
end

# RESPONSE =============================================


# OTHER ================================================
def clear
  system "clear && printf '\e[3J'"
end
clear
welcome
