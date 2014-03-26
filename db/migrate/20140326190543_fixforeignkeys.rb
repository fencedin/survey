class Fixforeignkeys < ActiveRecord::Migration
  def change
    remove_column :surveys, :question_id
    remove_column :questions, :response_id
    add_column :questions, :survey_id, :integer
    add_column :responses, :question_id, :integer
  end
end
