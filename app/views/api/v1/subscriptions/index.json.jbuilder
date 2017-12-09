json.challenge do
	json.extract! @challenge, :id, :title, :num_of_blocks, :start_date, :end_date
end

json.subscriptions @challenge.subscriptions.order(id: :asc) do |s|
	json.extract! s, :id, :can_edit, :condition
	json.num_of_completed_blocks s.blocks.completed.size
	json.user do
		json.extract! s.user, :id, :first_name, :last_name, :image_url
	end
end