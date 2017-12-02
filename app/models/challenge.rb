class Challenge < ApplicationRecord

  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions, source: :user
  
end
