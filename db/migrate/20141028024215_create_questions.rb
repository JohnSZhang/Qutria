class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.integer :best_answer_id, default: nil
      t.timestamps
    end
    add_index :questions, :user_id
  end
end
