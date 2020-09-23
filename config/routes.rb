Rails.application.routes.draw do
  devise_for :users
  root to: "reviews#index"
  resources :reviews do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  post "likes/:review_id/create" => "likes#create"
  post "likes/:review_id/destroy" => "likes#destroy"
  get "users/:id/likes" => "users#likes"
  resources :users, only: :show
end