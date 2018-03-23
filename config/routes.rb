Rails.application.routes.draw do

  get 'answers/create'

  get 'answers/update'

  get 'answers/delete'

	root 'questions#index'

	resources :questions

	devise_for :users

end
