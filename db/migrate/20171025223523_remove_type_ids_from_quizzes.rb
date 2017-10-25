class RemoveTypeIdsFromQuizzes < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :type_ids
  end
end
