json.challenge do
	json.extract! @challenge, :id, :title, :num_of_blocks, :start_date, :end_date
end

json.subscriptions @challenge.subscriptions do |s|
	json.id s.id
	json.num_of_completed_blocks 5
	json.user do
		json.extract! s.user, :id, :first_name, :last_name, :image_url
	end
end