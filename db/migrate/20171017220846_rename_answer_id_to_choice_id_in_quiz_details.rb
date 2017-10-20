class RenameAnswerIdToChoiceIdInQuizDetails < ActiveRecord::Migration[5.0]
  def change
    rename_column :quiz_details, :answer_id, :choice_id
  end
end
