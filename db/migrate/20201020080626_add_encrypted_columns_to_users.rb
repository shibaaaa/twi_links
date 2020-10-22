# frozen_string_literal: true

class AddEncryptedColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_token_secret, :string
  end
end
