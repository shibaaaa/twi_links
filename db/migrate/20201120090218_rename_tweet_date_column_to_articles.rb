# frozen_string_literal: true

class RenameTweetDateColumnToArticles < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :tweet_at, :tweeted_at
  end
end
