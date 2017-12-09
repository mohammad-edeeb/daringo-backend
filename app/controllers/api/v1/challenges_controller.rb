class Api::V1::ChallengesController < Api::V1::BaseController

	before_action :authenticate_api_user!

	def index
		@challenges = current_user.challenges.order(title: :asc)
	end

	def create
		participants = challenge_params[:participants]
		@challenge = Challenge.create(challenge_params.except(:participants).merge(owner: current_user))
		@challenge.subscribe(current_user)
		participants.each do |user|
			u = User.find_by_social_account_id(user[:social_account_id])
			if u.present?
				@challenge.subscribe(u)
			end
		end
	end

	private

	def challenge_params
		params.require(:data).require(:challenge).permit(:title,
			:description,
			:num_of_blocks,
			:start_date,
			:end_date,
			participants: [:social_account_id]
			)
	end

end