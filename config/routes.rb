Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"

  # match '*path', to: 'application#not_found', via: :all

  # get '/users/:user_id', to: 'users#show', as: 'user'
  # get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  # get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index, :show, :new, :create, :destroy], controller: 'posts' do
          collection do
            get 'all'
          end
          resources :comments, only: [:index, :create], controller: 'comments'
        end
      end
    end
  end
  
  

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy], controller: 'comments'
      resources :likes, only: [:create, :destroy], controller: 'likes'
    end
  end
end
