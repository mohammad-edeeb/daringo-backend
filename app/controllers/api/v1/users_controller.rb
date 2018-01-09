class Api::V1::UsersController < Api::V1::BaseController
	before_action :authenticate_api_user!, only: [:logout, :update_fcm_token]
	
	def social_login
		new_params = social_login_params

		social_account_id = new_params[:social_account_id]
		account_type = new_params[:account_type]

		# check if user was already registered
		@user = User.where(social_account_id: social_account_id, account_type: account_type).first

		# return user data if it was already registered
		if @user
			social_account_token = new_params[:social_account_token]
			fcm_token = new_params[:fcm_token]
			@user.update(social_account_token: social_account_token, fcm_token: fcm_token)
			render 'social_login', status: :ok and return
		end

		# insert a new user
		if new_params[:email].blank?
			new_params[:email] = new_params[:social_account_id] + "@daringo.com"
		end

		@user = User.new(new_params)
		if !@user.save
			render_unprocessable(@user.errors.full_messages[0]) and return
		end
	end

	def update_fcm_token
		current_user.update(update_fcm_token_params)
		render_empty_success
	end

	def logout
		current_user.update(fcm_token: nil)
		render_empty_success
	end

	private

	def update_fcm_token_params
		params.require(:data).require(:user).permit(:fcm_token)
	end

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