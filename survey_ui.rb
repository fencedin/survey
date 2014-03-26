require 'active_record'
require 'pry'

require './lib/survey'
require './lib/question'
require './lib/response'

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
    puts "      'v' view a survey"
    puts "      'a' to add a new survey"
    puts "      'e' to edit a survey"
    puts "      'd' to delete a survey"
    puts "      'b' to go back."
    choice = gets.chomp
    case choice
    when 'l'
      clear
      list_survey
    when 'v'
      list_survey
      view_survey
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

def view_survey
  puts "Enter name of survey you wish to view:"
  edit_choice = gets.chomp
  survey =  Survey.where({name: edit_choice}).first
  clear
  puts survey.name
  puts "=============================================================================="
  survey.questions.each do |q|
    puts "\t" + q.description
    q.responses.each do |r|
      puts "\t\t" + r.answer
    end
  end
  gets.chomp
  clear
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
  survey =  Survey.where({name: edit_choice}).first
  puts "Do you want to edit the [n]ame or modify [q]uestions?"
  case gets.chomp
  when 'n'
    clear
    edit_name(survey)
  when 'q'
    clear
    edit_survey_qs(survey)
  else
    puts "Invalid command."
  end
end

def edit_name(survey)
  old_name = survey.name
  puts "Rename survey to:"
  new_name = gets.chomp
  survey.update({name: new_name})
  clear
  puts "'#{old_name}' was changed to '#{new_name}'."
end

def show_survey_qs(survey)
  puts "Questions currently on the '#{survey.name}'"
  puts "==========================================================================================================="
  puts "description                                                                                          id"
  survey.questions.each {|sur| puts "  " + sur.description + " "*(100-sur.description.length) + sur.id.to_s}
  puts "\n\nAvailable questions to add:"
  puts "==========================================================================================================="
  puts "description                                                                                          id"
  al_qs = Question.where({survey_id: nil})
  qs_left = al_qs - survey.questions
  qs_left.each {|qs| puts "  " + qs.description + " "*(100-qs.description.length) + qs.id.to_s}
end

def edit_survey_qs(survey)
  show_survey_qs(survey)
  puts "\n\nDo you want to [a]dd or [r]emove a question. Use [b] to go back"
  case gets.chomp
  when 'a'
    add_q_to_s(survey)
  when 'r'
    remove_q_from_s(survey)
  when 'b'
    clear
    survey_manager
  else
    clear
    puts "Invalid option."
  end
end

def add_q_to_s(survey)
  puts "Enter id of question you would like to add"
  add_q_id = gets.chomp
  q = Question.where({id: add_q_id}).first
  q.update({survey_id: survey.id})
  clear
  edit_survey_qs(survey)
end

def remove_q_from_s(survey)
  puts "Enter id of question you would like to remove"
  rm_q_id = gets.chomp
  q = Question.where({id: rm_q_id}).first
  q.update({survey_id: nil})
  clear
  edit_survey_qs(survey)
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
  choice = nil
  until choice == 'b'
    puts "Enter 'l' to list all questions"
    puts "      'a' to add a new question"
    puts "      'e' to edit an existing question"
    puts "      'd' to delete a question"
    puts "      'b' to go back."
    choice = gets.chomp
    case choice
    when 'l'
      clear
      list_question
    when 'a'
      add_question
    when 'e'
      list_question
      edit_question
    when 'd'
      list_question
      delete_question
    when 'b'
      clear
      main_menu
    else
      clear
      puts "Invalid entry, please try again."
    end
  end
end

def list_question
  puts "Here is a list of all questions:"
  puts "=============================="
  Question.all.each {|question| puts question.description}
  puts "=============================="
end

def add_question
  puts "Name the question:"
  new_description = gets.chomp

  new_question = Question.new({description: new_description})
  clear
  if new_question.save
    puts "New question named '#{new_description}' created!"
  else
    new_question.errors.full_messages.each { |message| puts message }
  end
end

def edit_question
  puts "Enter name of question you wish to edit:"
  edit_choice = gets.chomp
  question = Question.where({description: edit_choice}).first
  puts "Do you want to edit the [n]ame or modify [q]uestions?"
  case gets.chomp
  when 'n'
    clear
    edit_description(question)
  when 'q'
    clear
    edit_question_r(question)
  else
    puts "Invalid command."
  end
end

def edit_description(question)
  old_description = question.description
  puts "Set question description to:"
  new_description = gets.chomp
  question.update({description: new_description})
  clear
  puts "'#{old_description}' was changed to '#{new_description}'."
end

def show_q_rs(question)
  puts "Answers currently on the '#{question.description}'"
  puts "==========================================================================================================="
  puts "answer                                                                                          id"
  question.responses.each {|q| puts "  " + q.answer + " "*(100-q.answer.length) + q.id.to_s}
  puts "\n\nAvailable answers to add:"
  puts "==========================================================================================================="
  puts "answer                                                                                          id"
  rs_left = Response.all - question.responses
  rs_left.each {|a| puts "  " + a.answer + " "*(100-a.answer.length) + a.id.to_s}
end

def edit_question_r(question)
  show_q_rs(question)
  puts "\n\nDo you want to [a]dd or [r]emove a answer. Use [b] to go back"
  case gets.chomp
  when 'a'
    add_r_to_q(question)
  when 'r'
    remove_r_from_q(question)
  when 'b'
    clear
    question_manager
  else
    clear
    puts "Invalid option."
  end
end

def add_r_to_q(question)
  puts "Enter id of answer you would like to add:"
  add_r_id = gets.chomp
  r = Response.where({id: add_r_id}).first
  r.update({question_id: question.id})
  clear
  edit_question_r(question)

end

def remove_r_from_q(question)
  puts "Enter id of answer you would like to remove:"
  rm_r_id = gets.chomp
  r = Response.where({id: rm_r_id}).first
  r.update({question_id: nil})
  clear
  edit_question_r(question)
end


def delete_question
  puts "Enter name of question you wish to delete:"
  edit_choice = gets.chomp
  question =  Question.where({description: edit_choice}).first
  question.destroy
  clear
  puts "'#{edit_choice}' has been deleted!"
end


# RESPONSE =============================================

def response_manager
  choice = nil
  until choice == 'b'
    puts "Enter 'l' to list all responses"
    puts "      'a' to add a new response"
    puts "      'e' to edit an existing response"
    puts "      'd' to delete a response"
    puts "      'b' to go back."
    choice = gets.chomp
    case choice
    when 'l'
      clear
      list_response
    when 'a'
      add_response
    when 'e'
      list_response
      edit_response
    when 'd'
      list_response
      delete_response
    when 'b'
      clear
      main_menu
    else
      clear
      puts "Invalid entry, please try again."
    end
  end
end

def list_response
  puts "Here is a list of all responses:"
  puts "=============================="
  Response.all.each {|response| puts response.answer}
  puts "=============================="
end

def add_response
  puts "Name the response:"
  new_answer = gets.chomp

  new_response = Response.new({answer: new_answer})
  clear
  if new_response.save
    puts "New response named '#{new_answer}' created!"
  else
    new_response.errors.full_messages.each { |message| puts message }
  end
end

def edit_response
  puts "Enter answer of response you wish to edit:"
  edit_choice = gets.chomp
  puts "New answer:"
  new_answer = gets.chomp
  response =  Response.where({answer: edit_choice}).first
  response.update({answer: new_answer})
  clear
  puts "'#{edit_choice}' was changed to '#{new_answer}'"
end

def delete_response
  puts "Enter name of response you wish to delete:"
  edit_choice = gets.chomp
  response =  Response.where({answer: edit_choice}).first
  response.destroy
  clear
  puts "'#{edit_choice}' has been deleted!"
end


# OTHER ================================================
def clear
  system "clear && printf '\e[3J'"
end
clear
welcome
