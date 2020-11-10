# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "articles#index"
  resources :privacy_policies, only: %i(index)
  resources :disclaimers, only: %i(index)
  resources :welcome, only: %i(index)
  resources :articles

  devise_for :users, only: [:sessions, :omniauth_callbacks], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
  }
end
