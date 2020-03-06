# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sessions
  root to: 'home#index'
  get 'users/me' => 'users#me'
  resources :users do
    member do
      get 'widgets'
    end
  end

  resources :widgets

  resource :session, only: %i[new create destroy]
end
