Rails.application.routes.draw do
  
  # 投稿者用
  # URL /contributors/sign_in ...
  devise_for :contributor, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ゲスト用
  devise_scope :contributor do
    post 'contributors/sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:index, :create, :destroy]
      get :tags, on: :collection
    end
    resources :contributors, only: [:show, :edit, :update] do
      get :unsubscribe, on: :collection
      patch :withdrawal, on: :member
    end
    resources :reports, only: [:new, :create]
    get 'search' => 'searches#search'
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :contributors, only: [:index, :show, :edit, :update]
    resources :genres, except: [:show, :new]
    resources :reports, only: [:index, :show]
    resources :comments, only: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
