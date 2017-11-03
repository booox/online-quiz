class RemoveColumnFromQuizzes < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :question_ids
    remove_column :quizzes, :question_count
  end
end
