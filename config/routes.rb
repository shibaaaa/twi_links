# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: [:sessions, :omniauth_callbacks], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks", only: %i(post)
  }
end
