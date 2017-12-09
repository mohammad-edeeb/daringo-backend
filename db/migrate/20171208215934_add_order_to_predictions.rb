class AddOrderToPredictions < ActiveRecord::Migration[5.1]
  def change
    add_column :predictions, :order, :integer
  end
end
