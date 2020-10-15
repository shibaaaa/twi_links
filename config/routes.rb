# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
