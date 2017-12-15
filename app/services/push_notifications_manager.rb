class PushNotificationsManager

	def self.fcm
		@@fcm ||= FCM.new(Rails.application.secrets.firebase_pn_key)
	end

	def self.send(notification, registration_ids)
		registration_ids = ["e99lothtASQ:APA91bGmU_CE-GEj_v9JjdgymBviIwas4v7FF_zyMODNpkMKAe7O1O2fYpvXIIHKQ0xXlrHrOwUeKfinhitw7BGGes_A-9qdrfBNmAGLY-pAx4QZ5nYSfq4MryZZM804WTPsGPO_LvMI"]
		response = fcm.send(registration_ids,
			notification: {
				title: notification.title,
				body: notification.description,
				sound: :default
				})
	end
end