# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "articles#index"

  get "welcome", to: "welcome#index", as: "welcome"

  resources :articles, only: %i(index create destroy)

  devise_for :users, only: [:sessions, :omniauth_callbacks], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
  }
end
