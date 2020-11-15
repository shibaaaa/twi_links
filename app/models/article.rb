# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  class << self
    def insert_from_tweets(user)
      insert_articles = Article.fetch_liked_tweets(user).map do |tweet|
        unless tweet.attrs[:entities][:urls].empty?
          article_url = tweet.attrs[:entities][:urls].first[:expanded_url]
          ({
            url: article_url,
            title: Article.fetch_title(article_url),
            image_meta: Article.fetch_og_image(article_url),
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
      Article.insert_all(insert_articles, unique_by: :url)
    end

    def unfavorite_tweet(tweet_id, user)
      Article.twitter_client(user.access_token, user.access_token_secret).unfavorite(tweet_id)
    end

    def twitter_client(token, token_secret)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = token
        config.access_token_secret = token_secret
      end
      client
    end

    def fetch_article_page(target_url)
      agent = Mechanize.new
      agent.user_agent_alias = "Windows Chrome"
      agent.get(target_url)
    end

    def fetch_title(target_url)
      Article.fetch_article_page(target_url).title
    end

    def fetch_og_image(target_url)
      Article.fetch_article_page(target_url).at('meta[property="og:image"]')[:content]
    end

    def fetch_liked_tweets(user)
      Article.twitter_client(user.access_token, user.access_token_secret).favorites
    end
  end
end
