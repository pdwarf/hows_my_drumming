Rails.application.routes.draw do
  devise_for :users
  resources :drum_sessions, only: [:index, :show, :new, :create, :update] do
    resources :reactions, only: [:create]
    resources :comments, only: [:create]
  end
  
  get 'qr_code', to: 'drum_sessions#qr_code', as: 'qr_code'
  get ':username/feedback', to: 'drum_sessions#feedback', as: 'user_feedback'
  
  root 'drum_sessions#index'
end

