# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  def self.find_or_create_from_tweets(user)
    Article.fetch_liked_tweets(user.access_token, user.access_token_secret).each do |tweet|
      unless tweet.attrs[:entities][:urls].empty?
        user.articles.find_or_create_by(url: tweet.attrs[:entities][:urls].first[:expanded_url]) do |article|
          article.user_id =         user.id
          article.tweet_date =      tweet.attrs[:created_at]
          article.tweet_url =       tweet.url.to_s
          article.tweet_user_meta = tweet.attrs[:user][:profile_image_url_https]
        end
      end
    end
  end

  private
    def self.fetch_liked_tweets(token, token_secret)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = token
        config.access_token_secret = token_secret
      end
      client.favorites
    end
end
