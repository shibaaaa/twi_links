# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url, null: false
      t.string :tweet_url, null: false
      t.string :tweet_user_meta, null: false

      t.timestamps
    end
  end
end
