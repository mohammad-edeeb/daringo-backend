Rails.application.routes.draw do

	namespace :api do
		namespace :v1 do

			post 'users/social_login'

			resources :challenges , only: [:index, :create]

		end
	end
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
