Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :new, :destroy]

  resources :questions
  resources :answers, only: [:destroy, :edit, :update, :create]

  resources :tags, only: [:destroy, :edit, :update, :create, :index, :show] do
    resource :favorite, only: [:create, :destroy]
  end
  resources :taggables, only: [:create, :destroy]
  resource :favorite, only: [:show]

  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :votes, only: [:create]
  delete "votes", to: "votes#destroy"
  post "vote", to: "votes#upvote"
  delete "vote", to: "votes#downvote"

# Backbone App
  namespace :api do
    resource :session, only: [:create, :destroy] do
      get "current", to: "sessions#current"
    end
    resources :users, only: [:create, :destroy, :index, :show, :update]
    resources :questions, only: [:create, :show, :index, :update, :destroy]
    post "questions/:id/best", to: "questions#best_answer"
    resources :answers, only: [:create, :destroy, :update, :show]
    resources :comments, only: [:create, :destroy, :update]
    resources :tags, only: [:destroy, :edit, :update, :create, :index, :show] do
      resource :favorite, only: [:create, :destroy]
    end
    resources :taggables, only: [:create]
    delete "taggables", to: "taggables#destroy"
    resource :favorite, only: [:show]
    post "vote", to: "votes#upvote"
    delete "vote", to: "votes#downvote"
    post "chat/:channel/", to: "chats#get_chat"
  end

# Switch between rails and backbone here
  root to: "apps#index"
# root to: "questions#index"
end
