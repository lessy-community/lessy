Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:create] do
      collection do
        get '/me', action: 'me', as: 'me'
        post '/authorize', action: 'authorize', as: 'authorize'
        post '/:token/activate', action: 'activate', as: 'activate'
      end
    end
    resources :projects, only: [:create]
  end

  root 'application#client'
  get '*path', to: 'application#client'
end
