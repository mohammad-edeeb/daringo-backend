json.challenges @challenges do |challenge|
	json.extract! challenge, :id, :title, :start_date, :end_date, :completed, :num_of_blocks

	json.owner do
		json.extract! challenge.owner, :id
	end

	if challenge.winner
		json.winner do	
			json.extract! challenge.winner, :id, :first_name, :last_name
		end
	end

	json.num_of_completed_blocks challenge.blocks.completed.size

	json.participants challenge.users do |user|
		json.extract! user, :id, :first_name
	end
end