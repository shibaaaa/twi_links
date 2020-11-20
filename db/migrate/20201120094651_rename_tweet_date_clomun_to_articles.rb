# frozen_string_literal: true

class RenameTweetDateClomunToArticles < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :tweet_date, :tweeted_at
  end
end
