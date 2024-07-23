Rails.application.routes.draw do
  get 'tarefas/new'
  get 'tarefas/create'
  get 'tarefa/index'

  get "/", to: "login#new"
  get "/home", to: "home#index"
  get "/cadastro", to: "cadastro#new"
  get "/cadastrotarefa", to: "cadastrotarefa#new"
  get "/listpage", to: "listpage#index"
  get "/listmembros", to: "cadastro#listmembros", as: "listmembros"
  get "/editmembro", to: "cadastro#editmembro", as: "editmembro"

  delete "/deletemembro", to: "cadastro#delete_membro", as: "delete_membro"
  patch "/updatemembro", to: "cadastro#update_membro", as: "update_membro"

  get 'login', to: 'login#new'
  post 'login', to: 'login#create'
  delete 'logout', to: 'login#destroy'

  get "go_cadastro" => "cadastro#index"

  # Routes for edit actions
  get 'edit/:id', to: 'edit#edit', as: 'edit_edit'
  post 'edit/:id/update', to: 'edit#update', as: 'update_edit'
  delete 'edit/:id', to: 'edit#destroy', as: 'destroy_edit'

  patch 'edit/:id/updatedatetime', to: 'edit#updatedatetime', as: 'updatedatetime_edit'

  resources :tarefas, only: [:new, :create]
  resources :cadastrotarefa, only: [:new, :create]
  resources :cadastro, only: [:new, :create]
end
