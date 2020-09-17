Rails.application.routes.draw do
  devise_for :users
  root to: "reviews#index"
  resources :reviews do
    resources :comments, only: :create
  end
  get 'reviews/search'
end