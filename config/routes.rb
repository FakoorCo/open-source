Rails.application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  root 'static_pages#index'
  get 'privacy', to: 'static_pages#privacy'
  get 'about', to: 'static_pages#about'

  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end

  resources :lessons, only: [:show]

  namespace :instructor do
    resources :lessons, only: [:update, :destroy]
    resources :sections, only: [:update, :destroy, :edit] do
      resources :lessons, only: [:create, :edit]
    end
    resources :courses, only: [:new, :create, :show, :update, :destroy, :edit] do
      resources :sections, only: [:create, :edit]
    end
  end


end
