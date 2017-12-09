class AddCanEditToSubscription < ActiveRecord::Migration[5.1]
  def change
  	add_column :subscriptions, :can_edit, :boolean, default: true
  end
end
