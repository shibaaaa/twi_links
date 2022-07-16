# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  class << self
    def insert_from_tweets(tweets, user_id)
      crawler = Scrape.new
      article_params = []
      Parallel.each(tweets, in_threads: 10) do |tweet|
        next if tweet.uris.blank?
        article_url = tweet.uris.first.expanded_url.to_s

        begin
          page = crawler.access_page(article_url)
        rescue => e
          next if timeout?(e) || e.response_code == "404"
          ErrorUtility.log e
        end

        article_params << self.build_params(article_url, crawler, page, user_id, tweet)
      end

      return if article_params.empty?

      Article.insert_all(article_params, unique_by: :url)
    end

    private
      def build_params(article_url, crawler, page, user_id, tweet)
        now = Time.current
        {
          url:             article_url,
          title:           crawler.fetch_title(page),
          image_meta:      crawler.fetch_og_image(page),
          user_id:,
          tweet_id:        tweet.id,
          tweeted_at:      tweet.created_at,
          tweet_url:       tweet.url.to_s,
          tweet_user_meta: tweet.user.profile_image_url_https.to_s,
          updated_at:      now,
          created_at:      now
        }
      end

      def timeout?(error)
        timeout_errors = [Timeout::Error, Net::ReadTimeout]
        timeout_errors.include?(error.class)
      end
  end
end
