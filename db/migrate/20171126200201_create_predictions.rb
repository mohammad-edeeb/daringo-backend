class CreatePredictions < ActiveRecord::Migration[5.1]
  def change
    create_table :predictions do |t|
      t.references :subscription, foreign_key: true
      t.string :text
      t.boolean :completed

      t.timestamps
    end
  end
end
