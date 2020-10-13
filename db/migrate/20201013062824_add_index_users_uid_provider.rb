# frozen_string_literal: true

class AddIndexUsersUidProvider < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:uid, :provider], unique: true
  end
end
