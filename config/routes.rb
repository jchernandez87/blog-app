Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  resources :users, only: [ :index, :show ] do
    resources :posts, only: [ :index, :show, :new, :create, :destroy ] do
      resources :comments, only: [:new, :create, :destroy ]
    end
  end

  put '/posts/like', to: 'posts#like', as: 'like'
end
