Rails.application.routes.draw do
  devise_for :users
  root "products#index"

  namespace :admin do
    resources :products do
      resources :photos, only: [:create, :destroy]
    end
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
    resources :users do
      member do
        post :to_admin
        post :to_normal
      end
    end
    resources :product_options, only: :index
    resources :purchases
    resources :sale_platforms
    resources :inventories do
      resources :inventory_transactions
    end
  end

  namespace :account do
    resources :orders
  end


  resources :orders do
    member do
      get :pay_with_credit_card
      post :pay2go_cc_notify
    end
  end
  resources :carts do
    collection do
      post :checkout
      delete :clean
    end
  end
  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :items, controller: "cart_items"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
