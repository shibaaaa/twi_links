# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def index
    if user_signed_in?
      "ブックマーク一覧"
    else
      render "welcome/index"
    end
  end

  def destroy
  end
end
