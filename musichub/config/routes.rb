Rails.application.routes.draw do
  resources :projects
  resources :teams
  resources :categories
  resources :shots do
    resources :comments
    member do
      put 'like', to: 'shots#like'
      put 'unlike', to: 'shots#unlike'
    end
  end
  devise_for :users, controllers: { registrations: 'registrations', sessions:'sessions' }
  resources :users, only: [:show]

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
