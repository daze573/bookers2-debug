Rails.application.routes.draw do
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
  get "tag_search" => "tag_searches#tag_search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    get "search", to: "users#search"
    resource :relationships, only: [:create, :destroy]
    member do
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
