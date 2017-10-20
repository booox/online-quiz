class RemoveUserIdFromQuizQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_column :quiz_questions, :user_id
  end
end
