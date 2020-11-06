# frozen_string_literal: true

class AddTweetidToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :tweet_id, :string
  end
end
