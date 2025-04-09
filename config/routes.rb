Rails.application.routes.draw do
  
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :artists, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end
  
  namespace :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get  'users/unsubscribe' => 'users#unsubscribe', as:'unsubscribe' #退会確認画面へのパス
    patch 'users/withdraw' => 'users#withdraw', as:'withdraw' #退会処理アクションのパス
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
    end
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :goods, only: [:create, :destroy]
      resource :comments, only: [:create, :destroy]
    end
    resources :genres, only: [:index, :show]
    resources :artists, only: [:index, :show]
  end
  
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
