# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i(create destroy)

  ARTICLES_NUM = 12
  def index
    if user_signed_in?
      @articles = current_user.articles.order(tweeted_at: "DESC").page(params[:page]).per(ARTICLES_NUM)
    else
      render "welcome/index", layout: "welcome"
    end
  end

  def create
    liked_tweets = TwitterApi.new(current_user.access_token, current_user.access_token_secret).fetch_liked_tweets
    result = Article.insert_from_tweets(liked_tweets, current_user.id)
    message =
      result.nil? ? "いいねしたツイートの中に記事のURLがありませんでした。" : "いいねしたツイートから記事を取得しました。"
    redirect_to root_path, notice: message
  rescue Twitter::Error::TooManyRequests => e
    redirect_to root_path, alert: "いいねの数が多すぎるため、読み込めませんでした。"
    ErrorUtility.log_and_notify e
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    TwitterApi.new(current_user.access_token, current_user.access_token_secret).unfavorite_tweet(@article.tweet_id)
    @article.destroy
    redirect_to articles_url, notice: "記事を削除しました。"
  end
end
