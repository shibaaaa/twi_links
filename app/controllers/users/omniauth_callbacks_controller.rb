# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!

  def twitter
    callback_from :twitter
  end

  private
    def callback_from(provider)
      provider = provider.to_s
      @user = User.find_for_twitter_oauth(request.env["omniauth.auth"])

      if @user.persisted?
        flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to welcome_url
      end
    end
end
