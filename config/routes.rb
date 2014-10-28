Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]
  resources :questions
  resources :answers, only: [:destroy, :edit, :update, :create]
  root to: "questions#index"
end
