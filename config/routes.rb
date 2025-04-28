Rails.application.routes.draw do
  get 'events/index'
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do # ゲストログイン
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  namespace :admin do
    root to: 'posts#index'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :artists, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resource :comments, only: [:destroy]
    end
    resources :comments, only: [:index] # 全コメントを表示
    resources :groups, only: [:index, :destroy]
  end
  
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    
    get 'users/mypage' => 'users#mypage', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit'
    patch 'users/information' => 'users#update', as: 'update'
    get 'users/unsubscribe' => 'users#unsubscribe', as:'unsubscribe' # 退会確認画面
    patch 'users/withdraw' => 'users#withdraw', as:'withdraw' # 退会処理アクション
    get 'users/goods' => 'users#goods', as: 'user_goods' # いいねしたした一覧
    get 'users/posts' => 'users#posts', as: 'user_posts' # 投稿した一覧
    get 'users/groups' => 'users#groups', as: 'user_groups' # 参加グループ一覧
    
    resources :users, only: [:index, :show]

    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :permits, only: [:index, :create, :update, :destroy] do
        post :reapply, on: :member # 再申請アクション
      end

      member do
        get 'permits_list' # グループ単位で申請一覧を見るページ
      end
      
      resource :group_users, only: [:create, :destroy]
    end
    
    

    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :goods, only: [:create, :destroy]
      resource :comments, only: [:create, :destroy]
    end
    resources :genres, only: [:index, :show]
    resources :artists, only: [:index, :show]
  end
  
  # カレンダー機能
  resources :events, only: [:index]
  
  # 検索機能
  get 'search', to: 'searches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
