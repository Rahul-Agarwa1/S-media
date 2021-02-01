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

  get 'users/:user_id/friends',to: "users#friends",as: 'user_friends'

  get 'users/:user_id/pendingrequests',to: "users#pendingrequests",as: 'user_pending_request'
  
  get 'users/:user_id/receievedrequests',to: "users#receievedrequests",as: 'user_receieved_request'
  
  post 'users/accept_request/:user_id', to: "friendships#accept",as: 'accept_request'
  
  delete 'users/unfriend/:user_id',to:"friendships#unfriend",as: "user_unfriend"

  resources:users, only: [:show, :destroy] do
    resources:friendships
  end  




  



end
