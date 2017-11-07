class CreateFeelings < ActiveRecord::Migration[5.0]
  def change
    create_table :feelings do |t|
      t.integer :user_id, index: true
      t.integer :question_id, index: true
      t.string :value, default: ""

      t.timestamps
    end
  end
end
