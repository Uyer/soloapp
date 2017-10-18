Rails.application.routes.draw do
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'register', to: 'devise/registrations#new', as: "new_user_registration"
    delete 'logout', to: 'devise/sessions#destroy'
  end

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users
  resources :products
  
  resources :orders, only: [:index, :show, :create, :destroy]
  
  get 'static_pages/about'
  get 'static_pages/contact'
  get 'static_pages/landing_page'
  get 'static_pages/index'
  root 'static_pages#landing_page'

  post 'static_pages/thank_you'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
