class RenameColumnQuesitonIdToQuestionIdInFavorites < ActiveRecord::Migration[5.0]
  def change
    rename_column :favorites, :quesiton_id, :question_id
  end
end
