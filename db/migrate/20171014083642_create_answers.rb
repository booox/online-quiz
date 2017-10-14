class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :question_id, :index => true
      t.string :title
      t.boolean :is_right

      t.timestamps
    end
  end
end
