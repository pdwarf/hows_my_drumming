Rails.application.routes.draw do
  devise_for :users
  resources :drum_sessions, only: [:index, :show, :new, :update] do
    resources :reactions, only: [:create]
    resources :comments, only: [:create]
  end
  get 'users/:user_id/feedback', to: 'drum_sessions#feedback', as: 'user_feedback'
  root 'drum_sessions#index'
end