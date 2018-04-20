Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  namespace :api do
    namespace :v1 do
      get '/google_oauth', to: 'google#get_auth_url'
      get '/google_oauth2callback', to: 'google#start_session'
    end
  end
end
