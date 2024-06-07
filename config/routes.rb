Rails.application.routes.draw do
  get 'tarefas/new'
  get 'tarefas/create'
  get 'tarefa/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get "/", to: "login#index"
  get "/login", to: "login#login"
  get "/home", to: "home#index"
  get "/cadastro", to: "cadastro#index"
  get "/cadastrotarefa", to: "cadastrotarefa#new"
  get "/listpage", to: "listpage#index"

  get "go_cadastro" => "cadastro#index"

  resources :tarefas, only: [:new, :create]
  resources :cadastrotarefa, only: [:new, :create]
end
