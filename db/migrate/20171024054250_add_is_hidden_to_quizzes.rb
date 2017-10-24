class AddIsHiddenToQuizzes < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :is_hidden, :boolean, default: true
  end
end
