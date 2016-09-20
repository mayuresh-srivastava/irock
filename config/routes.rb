Rails.application.routes.draw do
  
  devise_for :users
  resources :achievements do
    resources :encouragements, only: [ :new, :create]
  end
  root to: 'welcome#index'  
end
