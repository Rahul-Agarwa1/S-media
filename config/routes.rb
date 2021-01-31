Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new' 
  end

  root 'welcome#index'

  resources :posts do
    resources :likes
    resources :comments do
      resources :likes
    end
  end

  get 'myprofile', to: 'users#myprofile'

  get 'myfriends', to: 'users#myfriends'

  get 'search_friend', to: 'users#search'

  get 'friend_results', to: 'users#friend_results'

  resources :users





  



end
