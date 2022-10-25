Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resource :session, only: [:create, :new, :destroy]
  resources :users, only: [:create, :new, :show]
end
