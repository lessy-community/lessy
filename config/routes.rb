Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:create]
  end

  root 'application#client'
  get '*path', to: 'application#client'
end
