class Api::V1::UsersController < Api::V1::BaseController

	def social_login

		social_account_id = social_login_params[:social_account_id]
		account_type = social_login_params[:account_type]

		# check if user was already registered
		@user = User.where(social_account_id: social_account_id, account_type: account_type).first

		# return user data if it was already registered
		if @user
			social_account_token = social_login_params[:social_account_token]
			@user.update(social_account_token: social_account_token)
			render 'social_login', status: :ok and return
		end

		# insert a new user
		if !social_login_params[:email]
			social_login_params[:email] = social_login_params[:social_account_id] + "@greenbook.com"
		end

		@user = User.new(social_login_params)
		if !@user.save
			render_unprocessable(@user.errors.full_messages[0]) and return
		end
	end

	private

	def social_login_params
		params.require(:data).require(:user).permit(:account_type,
			:social_account_id,
			:social_account_token,
			:image_url,
			:email,
			:first_name,
			:last_name,
			:fcm_token)
	end

end