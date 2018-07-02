Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:create] do
      collection do
        get 'me', action: 'show'
        post 'me/projects', module: :users, controller: 'users/projects', action: :create
        get 'me/projects', module: :users, controller: 'users/projects', action: :index
        post 'me/tasks', module: :users, controller: 'users/tasks', action: :create
        get 'me/tasks', module: :users, controller: 'users/tasks', action: :index
        post 'me/terms_of_services', controller: :users, action: :accept_tos
      end
    end

    namespace :users do
      resources :authorizations, only: [:create]
      resources :activations, only: [:create]
    end

    patch '/projects/:id', to: 'projects#update', as: 'project'
    resources :projects, only: [:show] do
      member do
        put 'state', action: :update_state
      end
    end

    patch '/tasks/:id', to: 'tasks#update', as: 'task'
    resources :tasks, only: [:show] do
      member do
        put 'state', action: :update_state
        put 'order', action: :update_order
      end
    end

    get '/terms_of_services/current'

    get '/', to: 'welcome#index'

    get '*path', to: 'welcome#not_found'
    post '*path', to: 'welcome#not_found'
    patch '*path', to: 'welcome#not_found'
    put '*path', to: 'welcome#not_found'
    delete '*path', to: 'welcome#not_found'
  end

  namespace :admin do
    resources :user_sessions, only: [:create]
    get :login, to: 'user_sessions#new', as: :login
    post :logout, to: 'user_sessions#destroy', as: :logout

    resources :users
    resources :terms_of_services

    root to: 'users#index'
  end

  root 'application#client'
  get '*path', to: 'application#client'
end
