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
          article_title = Scraper.fetch_title(page)
          article_image = Scraper.fetch_og_image(page)
        rescue => e
          next if e.class == Timeout::Error || e.response_code == "404"
          ErrorUtility.log e
        end

        article_params << {
          url:             article_url,
          title:           article_title,
          image_meta:      article_image,
          user_id:,
          tweet_id:        tweet.id,
          tweeted_at:      tweet.created_at,
          tweet_url:       tweet.url.to_s,
          tweet_user_meta: tweet.user.profile_image_url_https.to_s,
          updated_at:      Time.current,
          created_at:      Time.current
        }
      end

      Article.insert_all(article_params, unique_by: :url)
    end
  end
end
