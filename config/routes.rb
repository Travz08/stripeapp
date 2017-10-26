Rails.application.routes.draw do

  get 'transactions/show'

  resources :products
  devise_for :users
  resources :charges, only: [:new, :create]
  authenticated :user do
   root 'products#index', as: :authenticated_root
  end
  root to: 'home#index'

  get '/purchased', to: 'transactions#show', as: 'mypurchase'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
