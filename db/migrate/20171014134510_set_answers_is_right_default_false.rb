class SetAnswersIsRightDefaultFalse < ActiveRecord::Migration[5.0]
  def change
    change_column_default :answers, :is_right, false
  end
end
