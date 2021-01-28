Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  devise_for :users, module: "users"
  devise_for :admin, controllers: { sessions: 'admin/sessions' }
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #singular recourse
  resource :admin, controller: :admin do
    resources :categories do
      post 'meta_data', on: :member
      post 'products', on: :member
    end
    resources :users
  end

  namespace :admin do
    resources :orders do
      get 'shipment', on: :member
      post 'shipment', on: :member
    end
    resources :products do
      get 'inbound', on: :member
      post 'inbound', on: :member
    end
  end

  resources :products, only: :show

  resource :account, controller: :account do
    resources :orders do
      resource :payment, controller: :payment, only: [:new, :create] do
        post 'create_transaction', to: 'payment#create_transaction'
      end
    end
    resource :address, controller: :address
  end
  resource :welcome do
    post 'selected', on: :member
    post 'qty_change', on: :member
  end
  resource :cart do
    post 'qty_change', on: :member
  end
end