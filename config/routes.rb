Lildebbie::Application.routes.draw do
  root to: 'home#index'

  match '/login' => 'sessions#create', as: :login
  match '/logout' => 'sessions#destroy', as: :logout
  match '/auth/:provider/callback' => 'sessions#create'
  get '/register' => 'users#new', as: :register
  post '/register' => 'users#create'

  get '/new' => 'projects#new', as: :new_project
  post '/new' => 'projects#create'

  get '/autocomplete/users' => 'users#autocomplete'

  get '/:username' => 'projects#index', as: :projects
  get '/:username/:projectname' => 'projects#show', as: :project
  put '/:username/:projectname' => 'projects#update'
  delete '/:username/:projectname' => 'projects#destroy'
  scope '/:username/:projectname', as: :project do
    resources :targets

    get 'admin' => 'projects#admin', as: :admin
    post 'grants' => 'project_grants#create', as: :grants
    put 'grants/:username2' => 'project_grants#update', as: :grant
    delete 'grants/:username2' => 'project_grants#destroy'
  end
end
