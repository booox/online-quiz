class RenameQuizzesTypeToQuizType < ActiveRecord::Migration[5.0]
  def change
    rename_column :quizzes, :type, :quiz_type
  end
end
