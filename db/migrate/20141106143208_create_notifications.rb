class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :new_object, polymorphic: true
      t.references :notified_on, polymorphic: true
      t.integer :user_id
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
