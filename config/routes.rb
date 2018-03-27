Rails.application.routes.draw do

	root 'questions#index'

	post "/voteup", to: "votes#voteup"
	post "/votedown", to: "votes#votedown"

	resources :questions

	resources :answers, only: [:create, :update, :destroy]

	devise_for :users

end
