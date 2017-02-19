Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :endings, only: :index
  resource :game, only: :show
  resources :cards, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/ping", to: "ping#ping"
  root to: "ping#ping"
end
