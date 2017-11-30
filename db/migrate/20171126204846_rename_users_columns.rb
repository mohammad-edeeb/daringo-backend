class RenameUsersColumns < ActiveRecord::Migration[5.1]
  def change
  	rename_column :users, :fb_account_id, :social_account_id
  	rename_column :users, :fb_token, :social_account_token
  end
end
