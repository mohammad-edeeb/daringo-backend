class Challenge < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :subscriptions
  
end
