class RemoveQuizIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :quizzes, :category_id
  end
end
