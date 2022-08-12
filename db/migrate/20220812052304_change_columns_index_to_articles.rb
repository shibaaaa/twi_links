# frozen_string_literal: true

class ChangeColumnsIndexToArticles < ActiveRecord::Migration[7.0]
  def change
    remove_index :articles, :user_id
    remove_index :articles, :tweeted_at
    add_index :articles, [:user_id, :tweeted_at]
  end
end
