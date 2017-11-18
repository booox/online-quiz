class AddIsRandomToQuizzes < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :is_random, :boolean, default: false
  end
end
