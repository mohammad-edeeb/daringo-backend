Rails.application.routes.draw do

	root 'static#index'
	
	namespace :api do
		namespace :v1 do

			post 'users/social_login'
			delete 'users', to: "users#logout"

			resources :challenges , only: [:index, :create] do

				collection do
					get 'ended'
					delete 'unsubscribe'
				end

				resources :subscriptions, only: [:show, :index, :update] do

					member do
						post 'blocks/:block_id/toggle', to: 'subscriptions#toggle_block'
					end

				end
			end

		end
	end
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
