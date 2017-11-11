class AddCoverToQuiz < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :cover, :string
  end
end
