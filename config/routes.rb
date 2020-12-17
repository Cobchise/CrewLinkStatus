Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :dashboard, only: [:index]

  resources :server_monitors, only: [:index, :new, :create, :show] do
    collection do
      get :update_monitor 
    end
  end
  
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
