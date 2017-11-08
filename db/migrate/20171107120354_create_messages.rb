class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recepient_id
      t.string :subject
      t.integer :conversation_id
      t.text :content

      t.timestamps
    end
  end
end
