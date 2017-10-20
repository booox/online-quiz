class AddUserIdToQuizDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :quiz_questions, :user_id, :integer, index: true
  end
end
