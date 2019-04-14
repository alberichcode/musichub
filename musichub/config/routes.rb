Rails.application.routes.draw do
  resources :projects do
    get :overdue, on: :collection
    get :complete, on: :collection

    post '/delete_collaborator', to: 'projects#delete_collaborator'
    resources :project_comments
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
    sessions:'sessions', confirmations:'confirmations', invitations: 'invitations' }
  resources :users, only: [:show, :index] do
    as :user do
      put '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
    end
    member do
      get :follow
      get :unfollow
      get :followers
      get :following
    end
  end
  root 'home#index'
  get 'my_friends', to: "users#my_friends"
  get 'search_friends', to: "users#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
