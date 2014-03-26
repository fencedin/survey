class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :answers, :string
      t.timestamps
    end
    add_column :questions, :response_id, :integer
  end
end
