Rails.application.routes.draw do
  devise_for :users
  root to: "reviews#index"
  resources :reviews do
    resources :comments, only: :create
    collection do
      get 'search'
    end
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: :show
end