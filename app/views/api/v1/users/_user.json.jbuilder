json.user do
	json.extract! user, :id, :first_name, :last_name, :email, :image_url, :token, :account_type
end