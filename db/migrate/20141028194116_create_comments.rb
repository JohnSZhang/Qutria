class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.text :body, null: false
      t.references :commentable, polymorphic: true, null: false
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
