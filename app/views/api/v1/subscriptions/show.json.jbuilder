json.subscription do
	json.extract! @subscription, :id, :condition
	json.blocks @subscription.blocks.order(order: :asc) do |p|
		json.extract! p, :id, :order, :text, :completed
	end
end