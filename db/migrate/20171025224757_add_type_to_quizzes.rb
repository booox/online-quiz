class AddTypeToQuizzes < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :type, :string, default: ""
  end
end
