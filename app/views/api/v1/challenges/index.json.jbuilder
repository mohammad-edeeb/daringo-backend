json.challenges @challenges do |challenge|
	json.extract! challenge, :id, :title

	json.owner_user_id challenge.owner.id

	json.num_of_completed_predictions 5

	# json.participants User.all do |user|
	# 	json.extract! user, :first_name
	# end

	json.participants challenge.users do |user|
		json.extract! user, :first_name
	end
end