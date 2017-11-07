class CreateComplains < ActiveRecord::Migration[5.0]
  def change
    create_table :complains do |t|
      t.integer :user_id, index: true
      t.integer :question_id, index: true
      t.string :content
      t.boolean :is_replied, default: false

      t.timestamps
    end
  end
end
