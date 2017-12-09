class AddDefaultToBlockCompletedColumn < ActiveRecord::Migration[5.1]
  def change
  	change_column :blocks, :completed, :boolean, :default => false
  end
end
