class ChangeComplainContentFromStringToText < ActiveRecord::Migration[5.0]
  def change
    change_column :complains, :content, :text
  end
end
