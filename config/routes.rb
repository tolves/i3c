Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  devise_for :users, controllers: { sessions: 'users/sessions'
  }
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resource :admin, controller: :admin #singular recourse
  resources :products, path: '/admin/products' do
    resource :inbounds
  end
  resources :orders, path: '/admin/orders'
  resources :users, path: '/admin/users'
  resources :categories, path: '/admin/categories' do
    post 'meta_data', to: 'categories#meta_data'
    post 'ajax_products', to: 'categories#ajax_products'
  end
  resource :account, controller: :users
  resource :welcome do
    post 'ajax_session', to: 'welcome#ajax_session'
  end
  resource :cart
end