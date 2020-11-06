# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  def self.find_or_create_from_tweets(user)
    liked_tweets = Article.twitter_client(user.access_token, user.access_token_secret).favorites
    liked_tweets.each do |tweet|
      unless tweet.attrs[:entities][:urls].empty?
        user.articles.find_or_create_by(url: tweet.attrs[:entities][:urls].first[:expanded_url]) do |article|
          article.user_id =         user.id
          article.tweet_id =        tweet.id
          article.tweet_date =      tweet.attrs[:created_at]
          article.tweet_url =       tweet.url.to_s
          article.tweet_user_meta = tweet.attrs[:user][:profile_image_url_https]
        end
      end
    end
  end

  def self.unfavorite_tweet(tweet_id, user)
    Article.twitter_client(user.access_token, user.access_token_secret).unfavorite(tweet_id)
  end

  private
    def self.twitter_client(token, token_secret)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = token
        config.access_token_secret = token_secret
      end
      client
    end
end
