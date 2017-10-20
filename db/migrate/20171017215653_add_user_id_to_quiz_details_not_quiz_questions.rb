class AddUserIdToQuizDetailsNotQuizQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :quiz_details, :user_id, :integer, index: true
  end
end
