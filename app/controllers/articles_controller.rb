# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def index
    if user_signed_in?
      @articles = current_user.articles.order(tweet_date: "DESC")
    else
      render "welcome/index"
    end
  end

  def create
    Article.find_or_create_from_tweets(current_user)
    redirect_to articles_url, notice: "いいねしたツイートから記事を取得しました。"
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    Article.unfavorite_tweet(@article.tweet_id, @article.user)
    @article.destroy
    redirect_to articles_url, notice: "記事を削除しました。"
  end
end
