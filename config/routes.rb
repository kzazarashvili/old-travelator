Rails.application.routes.draw do
  devise_for :users

  resources :trips
end
