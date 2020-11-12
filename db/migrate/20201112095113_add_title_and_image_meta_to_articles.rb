# frozen_string_literal: true

class AddTitleAndImageMetaToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :title, :string
    add_column :articles, :image_meta, :text
  end
end
