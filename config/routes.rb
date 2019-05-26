Rails.application.routes.draw do
  root 'trips#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :trips

  authenticate :user, lambda { |u| u.admin? } do

    get '/admin', to: 'admin/countries#index'

    namespace :admin do
      resources :countries
      resources :users
    end
  end
end
