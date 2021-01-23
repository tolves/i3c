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
      post 'ajax_products', to: 'categories#ajax_products'
    end
    resources :users
  end

  resource :account, controller: :account do
    resources :orders
    resource :address, controller: :address
  end
  resource :welcome do
    post 'ajax_session', to: 'welcome#ajax_session'
    post 'ajax_total', to: 'welcome#ajax_session_amount'
  end
  resource :cart
end