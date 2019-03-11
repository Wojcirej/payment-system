Rails.application.routes.draw do
  namespace :api do
    resources :employees, only: [:index, :show, :create, :destroy]
    resources :users, only: [:create]
  end
end
