# frozen_string_literal: true

class RenameTweetdAtColumnArticles < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :tweeted_at, :tweet_date
  end
end
