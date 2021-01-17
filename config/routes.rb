Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  devise_for :users, controllers: { sessions: 'users/sessions'
  }
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resource :admin, controller: :admin #singular recourse
  namespace :admins do
    resources :products
    resources :orders
    resources :users
    resources :categories do
      post 'meta_data', to: 'categories#meta_data'
    end
  end
  resource :account, controller: :users
end