class PushNotificationsManager

	def self.fcm
		@@fcm ||= FCM.new(Rails.application.secrets.firebase_pn_key)
	end

	def self.send(notification, registration_ids)
		response = fcm.send(registration_ids,
			notification: {
				title: notification.title,
				body: notification.description,
				sound: :default
				})
		puts response
	end
end