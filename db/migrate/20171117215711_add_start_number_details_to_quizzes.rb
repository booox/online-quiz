class AddStartNumberDetailsToQuizzes < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :start_number, :integer, default: 0
    add_column :quizzes, :end_number, :integer, default: 0
    add_column :quizzes, :given_number, :integer, default: 0
    add_column :quizzes, :order_type, :string, defalut: "order"
    add_column :quizzes, :start_time, :datetime
    add_column :quizzes, :end_time, :datetime
  end
end
