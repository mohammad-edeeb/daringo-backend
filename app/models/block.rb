class Block < ApplicationRecord
  belongs_to :subscription

  scope :completed, -> {where(completed: true)}

end
