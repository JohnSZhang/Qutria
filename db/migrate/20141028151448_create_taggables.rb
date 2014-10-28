class CreateTaggables < ActiveRecord::Migration
  def change
    create_table :taggables do |t|
      t.integer :tag_id, null: false
      t.references :taggings, polymorphic: true
      t.timestamps
    end
  end
end
