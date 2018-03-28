Rails.application.routes.draw do

	root 'questions#index'

	post "/voteup", to: "votes#voteup"
	post "/votedown", to: "votes#votedown"

	resources :questions

	resources :answers, only: [:create, :update, :destroy]

	resources :comments, only: [:create]

	devise_for :users

end
