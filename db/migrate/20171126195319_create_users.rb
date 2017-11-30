class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :image_url
      t.string :email
      t.string :account_type
      t.string :fb_account_id
      t.string :fb_token

      t.timestamps
    end
  end
end
