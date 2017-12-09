class RenamePredictionsTableToBlocks < ActiveRecord::Migration[5.1]
  def change
  	rename_table :predictions, :blocks
  end
end
