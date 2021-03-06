class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id, index: true
      t.string :subject
      t.text :content
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
