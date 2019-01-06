Rails.application.routes.draw do
  root :to => "home#index"
  get 'home_projects/index'
  resources :tenants do
    resources :projects do
      get 'users', on: :member
      put 'add_user', on: :member
    end
  end
  resources :members
  resources :categories
  resources :teams
  resources :shots do
    resources :comments
    member do
      put 'like', to: 'shots#like'
      put 'unlike', to: 'shots#unlike'
    end
  end



  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => {
    :registrations => "milia/registrations",
    :confirmations => "milia/confirmations",
    :sessions => "milia/sessions",
    :passwords => "milia/passwords",
  }


  resources :users, only: [:show]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
