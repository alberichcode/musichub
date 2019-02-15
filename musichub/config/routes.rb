Rails.application.routes.draw do
  resources :projects do
    get :overdue, on: :collection
    get :complete, on: :collection

    post '/delete_collaborator', to: 'projects#delete_collaborator'
  end
  resources :categories
  resources :shots do
    resources :comments
    member do
      put 'like', to: 'shots#like'
      put 'unlike', to: 'shots#unlike'
    end
  end
  devise_for :users, controllers: { registrations: 'registrations',
    sessions:'sessions', confirmations:'confirmations' }
  resources :users, only: [:show]

  as :user do
    put '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  patch '/edit_user_project_permission', to: 'user_projects#edit_user_project_permission'
  namespace :admin do
    get 'dashboard' => 'dashboard#index', :as => :dashboard
    get 'users' => 'dashboard#users', :as => :users
    get 'users/:id' => 'dashboard#user_edit', :as => :user_edit
  end

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
