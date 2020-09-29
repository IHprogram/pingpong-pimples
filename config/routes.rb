Rails.application.routes.draw do
  devise_for :users
  root to: "reviews#index"
  resources :reviews, shallow: true do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  post 'likes/create', to: 'likes#create'
  delete 'likes/destroy', to: 'likes#destroy'

  get "users/:id/likes" => "users#likes" # いいね一覧表示のためのルーティング
  resources :users, only: :show
end