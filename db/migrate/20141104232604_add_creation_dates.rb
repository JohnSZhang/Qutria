class AddCreationDates < ActiveRecord::Migration
  def change
    add_column :questions, :meta_create_date, :datetime
    add_column :answers, :meta_create_date, :datetime
    add_column :comments, :meta_create_date, :datetime
  end
end
