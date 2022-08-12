# frozen_string_literal: true

class AddNotNullConstraintToArticles < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :tweeted_at, :date, null: false
    change_column :articles, :tweet_id, :string, null: false
    change_column :articles, :title, :string, null: false
    change_column :articles, :image_meta, :text, null: false
  end
end
