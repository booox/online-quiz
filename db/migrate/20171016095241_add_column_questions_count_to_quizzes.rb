class AddColumnQuestionsCountToQuizzes < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :question_count, :integer, default: 0
  end
end
