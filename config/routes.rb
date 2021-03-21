Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
  root to: 'homes#top'
  resources :items, only: [:new, :index,:show, :update, :edit, :create]
  resources :genres, only: [:index, :update, :edit, :create]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_details, only: [:update]
  end

   scope module: :public do
   root to: 'homes#top'
   get 'about' => 'homes#about'
   get 'customers/my_page' => 'customers#show', as: 'my_page'
   resources :customers, only: [:edit,:update]
   get 'customers/unsubscribe' => 'customers#unsubscribe'
   patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
   resources :items, only: [:index,:show]
   resources :cart_items, only: [:index,:update,:destroy,:create]
   delete 'cart_items' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
   post 'orders/confirm' => 'orders#confirm', as: 'orders_confirm'
   get 'orders/complete' => 'orders#complete', as: 'orders_complete'
   resources :orders, only: [:new,:create,:index,:show]
   resources :addresses, only: [:index,:edit,:create,:update,:destroy]
   end


end
