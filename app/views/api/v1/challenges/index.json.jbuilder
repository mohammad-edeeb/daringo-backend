json.challenges @challenges do |challenge|
	json.extract! challenge, :id, :title, :start_date, :end_date

	json.owner_user_id challenge.owner.id

	json.num_of_completed_blocks rand(50)

	# json.participants User.all do |user|
	# 	json.extract! user, :first_name
	# end

	json.participants challenge.users do |user|
		json.extract! user, :first_name
	end
end