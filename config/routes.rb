Rails.application.routes.draw do

  post "join_chatroom" => "chatrooms#join"

	resources :chatrooms do
		resource :chatroom_users
		resources :messages
	end

  devise_for :users

  root to: "chatrooms#index"

  post "change_chatroom_password" => "chatrooms#change_chatroom_password"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
