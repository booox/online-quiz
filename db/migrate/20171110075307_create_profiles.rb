class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, index: true
      t.string :nickname
      t.string :real_name
      t.string :organization
      t.string :department
      t.string :wechat
      t.string :qq

      t.timestamps
    end
  end
end
