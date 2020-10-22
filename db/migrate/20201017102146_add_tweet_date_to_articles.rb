# frozen_string_literal: true

class AddTweetDateToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :tweet_date, :date
  end
end
