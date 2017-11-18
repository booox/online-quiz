class RemoveOrderTypeFromQuizzes < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :order_type
  end
end
