class Challenge < ApplicationRecord

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id, required: false

  has_many :subscriptions, dependent: :destroy
  has_many :blocks, through: :subscriptions
  has_many :users, through: :subscriptions, source: :user

  def subscribe(user)
  	subscription = self.subscriptions.create(user: user)
  	(1..self.num_of_blocks).each do |i|
  		subscription.blocks.create(order: i)
  	end
  end
  
end
