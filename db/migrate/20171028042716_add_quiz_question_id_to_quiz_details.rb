class AddQuizQuestionIdToQuizDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :quiz_details, :quiz_question_id, :integer, index: true
  end
end
