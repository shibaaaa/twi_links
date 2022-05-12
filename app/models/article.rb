# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  class << self
    def insert_from_tweets(tweets, user_id)
      article_params = []
      Parallel.each(tweets, in_threads: 10) do |tweet|
        next if tweet.uris.blank?
        article_url = tweet.uris.first.expanded_url.to_s

        begin
          page = Scraper.access_page(article_url)
        rescue => e
          next if e.class == Timeout::Error || e.response_code == "404"
          ErrorUtility.log e
        end

        article_params << self.build_params(article_url, page, user_id, tweet)
      end

      Article.insert_all(article_params, unique_by: :url)
    end

    private
      def build_params(article_url, page, user_id, tweet)
        now = Time.current
        {
          url:             article_url,
          title:           Scraper.fetch_title(page),
          image_meta:      Scraper.fetch_og_image(page),
          user_id:,
          tweet_id:        tweet.id,
          tweeted_at:      tweet.created_at,
          tweet_url:       tweet.url.to_s,
          tweet_user_meta: tweet.user.profile_image_url_https.to_s,
          updated_at:      now,
          created_at:      now
        }
      end
  end
end
