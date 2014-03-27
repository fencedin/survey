class CreateJoinTables < ActiveRecord::Migration
  def change
    create_table :q_s do |t|
      t.column :survey_id, :integer
      t.column :question_id, :integer
      t.timestamps
    end

    create_table :q_r do |t|
      t.column :response_id, :integer
      t.column :question_id, :integer
      t.timestamps
    end

    remove_column :questions, :survey_id
    remove_column :responses, :question_id
  end
end
