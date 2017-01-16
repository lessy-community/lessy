Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:create] do
      collection do
        get 'me'
        post 'authorize'
        post '/:token/activate', action: 'activate', as: 'activate'
      end

      member do
        get '/projects/:project_name', to: 'projects#find', as: 'find_project'
      end
    end
    resources :projects, only: [:create, :update] do
      member do
        post 'start'
        post 'finish'
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
