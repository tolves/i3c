Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  devise_for :users, controllers: { sessions: 'users/sessions'
  }
  devise_for :admin, controllers: { sessions: 'admin/sessions' }
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #singular recourse
  resource :admin, controller: :admin do
    resources :products do
      resource :inbounds
    end
    resources :categories do
      post 'meta_data', to: 'categories#meta_data'
      post 'products', to: 'categories#products'
    end
    resources :users
  end

  resource :account, controller: :account do
    resources :orders do
      resource :payment, controller: :payment, only: [:new, :create] do
        post 'create_transaction', to: 'payment#create_transaction'
      end
    end
    resource :address, controller: :address
  end
  resource :welcome do
    post 'selected', to: 'welcome#selected'
    post 'qty_change', to: 'welcome#qty_change'
  end
  resource :cart do
    post 'qty_change', to: 'carts#qty_change'
  end
end