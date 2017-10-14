class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :category_id, index: true
      t.integer :type_id, index: true

      t.timestamps
    end
  end
end
