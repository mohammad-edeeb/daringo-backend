class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_many :blocks, dependent: :destroy, inverse_of: :subscription

  accepts_nested_attributes_for :blocks
end
