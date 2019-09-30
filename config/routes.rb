Rails.application.routes.draw do
  resources :comments
  namespace :api do
    namespace :v1 do
      resources :records
      resources :artists
      resources :articles do
        get "counts", controller: :articles, action: :count
        resources :comments
        
      end
    end
  end

  root to: "home#index"

  post "refresh", controller: :refresh, action: :create
  post "signin", controller: :signin, action: :create
  post "signup", controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy

end
