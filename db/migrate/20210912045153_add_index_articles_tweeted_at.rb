# frozen_string_literal: true

class AddIndexArticlesTweetedAt < ActiveRecord::Migration[6.0]
  def change
    add_index :articles, :tweeted_at
  end
end
