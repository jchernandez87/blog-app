Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [ :index, :show] do
    resources :posts, only: [ :index, :show, :new, :create ] do
      resource :comment, only: [ :new, :create ]
    end
  end

  put '/posts/like', to: 'posts#like', as: 'like'
end
