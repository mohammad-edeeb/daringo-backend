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

	def create
		invited_ids = challenge_params[:invited_ids]
		@challenge = Challenge.create(challenge_params.except(:invited_ids).merge(owner: current_user))
		@challenge.subscribe(current_user)
		invited_ids.each do |user|
			u = User.find_by_social_account_id(user[:facebook_id])
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
			invited_ids: [:facebook_id]
			)
	end

end