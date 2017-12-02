class User < ApplicationRecord
	has_many :subscriptions, dependent: :destroy
	has_many :challenges, through: :subscriptions, source: :challenge

	has_secure_token :token
end
