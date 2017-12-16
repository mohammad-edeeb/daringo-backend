class Api::V1::ChallengesController < Api::V1::BaseController

	before_action :authenticate_api_user!
	before_action :set_challenge!, only: [:complete]

	def index
		@challenges = current_user.challenges
			.where('end_date >= ? and winner_id is null', Time.now)
			.order(title: :asc)
	end

	# ended challenges or has winner
	def ended
		@challenges = current_user.challenges
			.where('end_date < ? or winner_id is not null', Time.now)
			.order(title: :asc)
		render 'index', status: :ok
	end

	def unsubscribe
		challenges_params = unsubscribe_params[:challenges]
		challenges_params.each do |param|
			challenge = Challenge.find_by_id(param[:id])
			if challenge.owner == current_user
				challenge.destroy
			else
				challenge.subscriptions.find_by_user_id(current_user.id).destroy
			end
		end
		render_empty_success
	end

	def create
		participants = challenge_params[:participants]
		@challenge = Challenge.create(challenge_params.except(:participants).merge(owner: current_user))
		@challenge.subscribe(current_user)
		registration_ids = []
		registration_ids << current_user.fcm_token
		participants.each do |user|
			u = User.find_by_social_account_id(user[:social_account_id])
			if u.present?
				if u.fcm_token
					registration_ids << u.fcm_token
				end
				@challenge.subscribe(u)
			end
		end
		notification = Notification.new(
			"New Challenge",
			current_user.first_name + " " + current_user.last_name + 
				" added you to challenge \"" + @challenge.title + "\""
			)
		PushNotificationsManager.send(notification, registration_ids)
	end

	def complete
		if @challenge.completed?
			render_unprocessable('Challenge already won by another participant') and return
		end
		@challenge.update(completed: true, winner: current_user)
		render_empty_success
	end

	private

	def set_challenge!
		@challenge = Challenge.find_by_id(params[:id])
		if !@challenge.present?
			render_unprocessable('Challenge not found')
		end
	end

	def challenge_params
		params.require(:data).require(:challenge).permit(:title,
			:description,
			:num_of_blocks,
			:start_date,
			:end_date,
			participants: [:social_account_id]
			)
	end

	def unsubscribe_params
		params.require(:data).permit(challenges: [:id])
	end

end