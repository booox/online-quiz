class AddComplainIdToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :complain_id, :integer, index: true
  end
end
