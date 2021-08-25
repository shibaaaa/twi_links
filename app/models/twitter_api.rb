# frozen_string_literal: true

class TwitterApi
  def initialize(access_token, access_token_secret)
    @access_token        = access_token
    @access_token_secret = access_token_secret
  end

  def fetch_liked_tweets
    twitter_client.favorites(count: 200)
  end

  def unfavorite_tweet(tweet_id)
    twitter_client.unfavorite(tweet_id)
  end

  private
    def twitter_client
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = @access_token
        config.access_token_secret = @access_token_secret
      end
      client
    end
end
