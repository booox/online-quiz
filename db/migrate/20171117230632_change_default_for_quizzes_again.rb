class ChangeDefaultForQuizzesAgain < ActiveRecord::Migration[5.0]
  def change
    change_column :quizzes, :start_number, :integer, default: nil
    change_column :quizzes, :end_number, :integer, default: nil
    change_column :quizzes, :given_number, :integer, default: nil
  end
end
