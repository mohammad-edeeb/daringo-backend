class Api::V1::ChallengesController < Api::V1::BaseController

	before_action :authenticate_api_user!

	def index
		@challenges = current_user.challenges
	end

	private

	def social_login_params
		params.require(:data).require(:user).permit(:account_type,
			:social_account_id,
			:social_account_token,
			:image_url,
			:email,
			:first_name,
			:last_name)
	end

end