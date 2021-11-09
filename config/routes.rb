Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  resources :groups, only: [:index, :new, :create, :show, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  resources :users,only: [:show,:index,:edit,:update] do
     resources :relationships, only: [:create, :destroy]
     get 'follow' => 'relationships#follow'
     get 'follower' => 'relationships#follower'
  end
  resources :books do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
end