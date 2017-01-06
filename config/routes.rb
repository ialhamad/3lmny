Rails.application.routes.draw do

  resources :admin
  resources :searches
  resources :announcements
  resources :videos
  resources :majors
  resources :faculties
  resources :documents do
    member do
      get :approve
    end
  end
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  resources :posts do
    resources :comments
    member do
      patch 'upvote', to: 'posts#upvote'
      patch 'downvote', to: 'posts#downvote'
    end
  end
  resources :courses do
    member do
      get 'posts', to: 'courses#posts'
      get 'documents', to: 'courses#documents'
      get 'videos', to: 'courses#videos'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  devise_scope :user do
    get 'users/:username', to: 'users/sessions#profile', as: 'user_profile'
    get 'users/:id/edit', to: 'users/registrations#edit', as: 'edit_user'
    get 'users', to: 'users/registrations#index', as: 'users'
    get 'login', to: 'users/sessions#new', as: 'login'
    get 'register', to: 'users/registrations#new', as: 'register'
  end

  authenticated :user do
    root to: "posts#index"
    # Rails 4 users must specify the 'as' option to give it a unique name
    # root :to => "main#dashboard", :as => "authenticated_root"
  end

  root to: "static_pages#index"
end
