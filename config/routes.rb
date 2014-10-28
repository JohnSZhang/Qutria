Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :questions
  root to: "users#index"
end
