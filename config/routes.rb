Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new' 
  end

  root 'welcome#index'

  resources :posts do
    resources :comments
  end



  



end
