Rails.application.routes.draw do

	root 'static#index'
	
	namespace :api do
		namespace :v1 do

			post 'users/social_login'

			resources :challenges , only: [:index, :create] do
				resources :subscriptions, only: [:show, :index, :update] do

					member do
						post 'blocks/:block_id/complete', to: 'subscriptions#complete_block'
					end

				end
			end

		end
	end
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
