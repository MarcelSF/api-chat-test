Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: [:index, :create] do
        resources :messages, only: [:create, :show]
        resources :replies, only: [:create, :index]
      end
    end
  end
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
