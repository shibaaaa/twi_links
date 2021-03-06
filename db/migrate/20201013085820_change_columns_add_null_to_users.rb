# frozen_string_literal: true

class ChangeColumnsAddNullToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :provider, false
    change_column_null :users, :uid, false
  end
end
