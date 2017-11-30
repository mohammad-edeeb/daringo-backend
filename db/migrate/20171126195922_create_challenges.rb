class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.references :user, foreign_key: true
      t.timestamp :end_date
      t.integer :num_of_blocks
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
