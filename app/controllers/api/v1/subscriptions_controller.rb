class Api::V1::SubscriptionsController < Api::V1::BaseController
	before_action :authenticate_api_user!
	before_action :set_challenge!
	before_action :set_subscription!, only: [:show, :update, :complete_block]

	def index
		@subscriptions = @challenge.subscriptions
	end

	def show

	end

	def update
		@subscription.update(condition: subscription_params[:condition], 
			blocks_attributes: subscription_params[:blocks])
		render_empty_success
	end

	def complete_block
		block = @subscription.blocks.find(params[:block_id])
		block.update(completed: true)
		@winner = !@subscription.blocks.where(completed: false).exists?
	end

	private

	def subscription_params
		params.require(:data).require(:subscription).permit(:condition,
			blocks: [:id, :text]
			)
	end

	def set_challenge!
		@challenge = Challenge.find_by_id(params[:challenge_id])
		if !@challenge.present?
			render_unprocessable('Challenge not found')
		end
	end

	def set_subscription!
		@subscription = @challenge.subscriptions.find_by_id(params[:id])
		if !@subscription.present?
			render_unprocessable('Subscription not found')
		end
	end

end