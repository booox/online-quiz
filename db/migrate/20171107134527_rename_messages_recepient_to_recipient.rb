class RenameMessagesRecepientToRecipient < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :recepient_id, :recipient_id
  end
end
