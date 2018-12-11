# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :users, only: :index do
        collection do
          post 'auth/register', to: 'users#register'
          post 'auth/login', to: 'users#login'
          get 'test', to: 'users#test'
        end
      end
      resources :groups
      resources :contacts
    end
  end
end
