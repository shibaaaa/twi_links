# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  class << self
    def insert_from_tweets(user)
      article_params = Parallel.map(fetch_liked_tweets(user), in_threads: 5) do |tweet|
        if tweet.uris?
          article_url = tweet.uris.first.expanded_url.to_s
          page = mechanize_agent.get(article_url)
          {
            url: article_url,
            title: fetch_title(page),
            image_meta: fetch_og_image(page),
            user_id: user.id,
            tweet_id: tweet.id,
            tweeted_at: tweet.created_at,
            tweet_url: tweet.url.to_s,
            tweet_user_meta: tweet.user.profile_image_url_https.to_s,
            updated_at: Time.current,
            created_at: Time.current
          }
        end
      end
      Article.insert_all(article_params.compact, unique_by: :url)
    end

    def unfavorite_tweet(article)
      twitter_client(article.user).unfavorite(article.tweet_id)
    end

    private
      def twitter_client(user)
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["TWITTER_API_KEY"]
          config.consumer_secret     = ENV["TWITTER_API_SECRET"]
          config.access_token        = user.access_token
          config.access_token_secret = user.access_token_secret
        end
        client
      end

      def mechanize_agent
        agent = Mechanize.new
        agent.user_agent_alias = "Windows Chrome"
        agent
      end

      def fetch_title(page)
        page.title || "No Title"
      rescue => e
        ErrorUtility.log_and_notify e
        "No Title"
      end

      def fetch_og_image(page)
        og_image = page.at('meta[property="og:image"]')
        og_image ? og_image[:content] : "no_image.svg"
      rescue => e
        ErrorUtility.log_and_notify e
        "no_image.svg"
      end

      def fetch_liked_tweets(user)
        twitter_client(user).favorites(count: 200)
      end
  end
end
