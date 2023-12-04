Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :assignments, only: [:index, :create, :show, :update, :destroy]
      resources :forms, only: [:index, :show, :create, :update, :destroy]
      resources :companies, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
