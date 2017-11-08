class AddQuizIdToComplains < ActiveRecord::Migration[5.0]
  def change
    add_column :complains, :quiz_id, :integer, index: true
  end
end
