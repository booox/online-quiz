class RemoveColumnFromQuizzesAgain < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :quiestion_ids
    remove_column :quizzes, :question_count
  end
end
