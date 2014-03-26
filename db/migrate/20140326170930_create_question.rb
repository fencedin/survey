class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :description, :string
      t.timestamps
    end
    add_column :surveys, :question_id, :integer
  end
end
