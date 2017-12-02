class Api::V1::ChallengesController < Api::V1::BaseController

	before_action :authenticate_api_user!

	def index
		if current_user.challenges.empty?
			Challenge.all.each do |challenge|
				challenge.subscriptions.create(user: current_user)
			end
		end
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