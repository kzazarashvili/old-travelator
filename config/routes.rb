Rails.application.routes.draw do
  root 'trips#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :trips
end
