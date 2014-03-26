class UpdateResponseColumn < ActiveRecord::Migration
  def change
    remove_column :responses, :answers
    add_column :responses, :answer, :string
    add_column :questions, :answer_id, :integer
  end
end
