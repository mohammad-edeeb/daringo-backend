json.challenges @challenges do |challenge|
	json.extract! challenge, :id, :title, :start_date, :end_date, :completed, :num_of_blocks

	json.owner do
		json.extract! challenge.owner, :id
	end

	json.num_of_completed_blocks challenge.blocks.completed.size

	json.participants challenge.users do |user|
		json.extract! user, :id, :first_name
	end
end