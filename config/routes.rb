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
      get :history, on: :collection
    end
    resources :users do
      get :history, on: :collection
    end
  end

  namespace :admin do
    resources :orders do
      match 'shipment', on: :member, via: [:get, :patch]
      get :history, on: :collection
    end
    resources :products do
      match 'inbound', on: :member, via: [:get, :post]
      get :history, on: :collection
    end
  end

  resources :products, only: :show

  resource :account, controller: :account do
    resources :orders do
      resource :payment, controller: :payment, only: [:new, :create] do
        post 'create_transaction', on: :member
      end
    end
    resource :address, controller: :address
  end
  resource :welcome, controller: :welcome do
    post 'selected', to: 'welcome#selected'
    post 'qty_change', to: 'welcome#qty_change'
  end
  resource :cart do
    post 'qty_change', on: :member
  end
end