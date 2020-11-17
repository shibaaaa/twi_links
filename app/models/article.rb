# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  class << self
    def insert_from_tweets(user)
      article_params = Parallel.map(fetch_liked_tweets(user), in_threads: 5) do |tweet|
        unless tweet.attrs[:entities][:urls].empty?
          article_url = tweet.attrs[:entities][:urls].first[:expanded_url]
          ({
            url: article_url,
            title: fetch_title(article_url),
            image_meta: fetch_og_image(article_url),
            user_id: user.id,
            tweet_id: tweet.id,
            tweet_date: tweet.attrs[:created_at],
            tweet_url: tweet.url.to_s,
            tweet_user_meta: tweet.attrs[:user][:profile_image_url_https],
            updated_at: DateTime.now,
            created_at: DateTime.now
          })
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

      def fetch_title(target_url)
        if mechanize_agent.get(target_url).title.nil?
          "No Title"
        else
          mechanize_agent.get(target_url).title
        end
      rescue => e
        ErrorUtility.log_and_notify e
        "No Title"
      end

      def fetch_og_image(target_url)
        if mechanize_agent.get(target_url).at('meta[property="og:image"]').nil?
          "no_image.svg"
        else
          mechanize_agent.get(target_url).at('meta[property="og:image"]')[:content]
        end
      rescue => e
        ErrorUtility.log_and_notify e
        "no_image.svg"
      end

      def fetch_liked_tweets(user)
        twitter_client(user).favorites(count: 200)
      end
  end
end
