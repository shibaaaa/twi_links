# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  class << self
    def insert_from_tweets(tweets, user_id)
      crawler = Scrape.mechanize_agent
      article_params = Parallel.map(tweets, in_threads: 10) do |tweet|
        next if tweet.uris.blank?
        article_url = tweet.uris.first.expanded_url.to_s

        begin
          page = Scrape.access_page(crawler, article_url)
          article_title = Scrape.fetch_title(page)
          article_image = Scrape.fetch_og_image(page)
        rescue Mechanize::ResponseCodeError => e
          if e.response_code == "404"
            next
          else
            article_title = "Not Found"
            article_image = "no_image.svg"
          end
        rescue => e
          ErrorUtility.log e
          article_title = "Not Found"
          article_image = "no_image.svg"
        end

        {
          url:             article_url,
          title:           article_title,
          image_meta:      article_image,
          user_id:         user_id,
          tweet_id:        tweet.id,
          tweeted_at:      tweet.created_at,
          tweet_url:       tweet.url.to_s,
          tweet_user_meta: tweet.user.profile_image_url_https.to_s,
          updated_at:      Time.current,
          created_at:      Time.current
        }
      end

      Article.insert_all(article_params.compact, unique_by: :url)
    end
  end
end
