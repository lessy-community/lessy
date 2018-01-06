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

    get '*path', to: 'welcome#not_found'
    post '*path', to: 'welcome#not_found'
    patch '*path', to: 'welcome#not_found'
    put '*path', to: 'welcome#not_found'
    delete '*path', to: 'welcome#not_found'
  end

  root 'application#client'
  get '*path', to: 'application#client'
end
