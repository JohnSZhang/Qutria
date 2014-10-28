Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :questions
  resources :answers, only: [:destroy, :update, :create]
  root to: "users#index"
end
