class RenameJoins < ActiveRecord::Migration
  def change
    create_table :qsurveys do |t|
      t.column :survey_id, :integer
      t.column :question_id, :integer
      t.timestamps
    end

    create_table :qresponses do |t|
      t.column :response_id, :integer
      t.column :question_id, :integer
      t.timestamps
    end

    drop_table :q_s
    drop_table :q_r
  end
end
