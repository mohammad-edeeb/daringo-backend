class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :challenge, foreign_key: true
      t.string :condition
      t.boolean :winner

      t.timestamps
    end
  end
end
