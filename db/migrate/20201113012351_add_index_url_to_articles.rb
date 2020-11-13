# frozen_string_literal: true

class AddIndexUrlToArticles < ActiveRecord::Migration[6.0]
  def change
    add_index :articles, :url, unique: true
  end
end
