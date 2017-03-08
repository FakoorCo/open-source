Rails.application.routes.draw do

  devise_for :users
  as :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  resource :dashboard, only: [:show]
  root 'static_pages#index'

  get 'privacy', to: 'static_pages#privacy'

  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end
  resources :lessons, only: [:show]
  namespace :instructor do
    resources :lessons, only: [:update, :edit]
    resources :sections, only: [:update, :edit] do
      resources :lessons, only: [:create]
    end
    resources :courses, only: [:new, :create, :show, :edit, :update] do
      resources :sections, only: [:create] do
      end
    end
  end

end


  # For details on the D
  # SL available within this file, see http://guides.rubyonrails.org/routing.html
