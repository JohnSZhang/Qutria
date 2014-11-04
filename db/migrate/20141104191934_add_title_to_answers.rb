class AddTitleToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :title, :text
  end
end
