class Addfilepickerfortagandquestion < ActiveRecord::Migration
  def change
    add_column :tags, :filepicker_url, :string
    add_column :questions, :filepicker_url, :string
  end
end
