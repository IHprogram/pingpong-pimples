Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
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
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :relationships, only: [:create, :destroy]
end