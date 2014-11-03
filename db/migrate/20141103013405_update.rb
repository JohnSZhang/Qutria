class Update < ActiveRecord::Migration
  def up
    remove_column :questions, :best_answer_id
    add_column :answers, :is_best, :boolean, default: false
  end

  def down
    add_column :questions, :best_answer_id, :integer
    remove_column :answers, :is_best
  end
end
