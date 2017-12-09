class AddStartDateToChallenge < ActiveRecord::Migration[5.1]
  def change
  	add_column :challenges, :start_date, :timestamp
  end
end
