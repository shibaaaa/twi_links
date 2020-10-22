# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def index
    if user_signed_in?
      Article.find_or_create_from_tweets(current_user, current_user.access_token, current_user.access_token_secret)
      @articles = current_user.articles.all
    else
      render "welcome/index"
    end
  end

  def create
  end

  def destroy
  end
end
