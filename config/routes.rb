Rails.application.routes.draw do

	resources :chatrooms do
		resource :chatroom_users
		resources :messages
	end

  devise_for :users

  root to: "chatrooms#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
