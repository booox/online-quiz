class AddColumnQuestionsCountToQuizzesAgain < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :question_ids
    add_column :quizzes, :questions_count, :integer, :default => 0

    # Quiz.pluck(:id).each do |i|
    #   Quiz.reset_counters(i, :questions)
    # end
  end
end
