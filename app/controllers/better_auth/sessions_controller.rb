# frozen_string_literal: true

module BetterAuth
  class SessionsController < ApplicationController
    skip_before_action :protect
    before_action :ensure_not_authenticated, except: :destroy

    def new; end

    def create
      user = user_class.find_or_create_by(email: session_params[:email])

      BetterAuth::UserMailer.magic_link(user).deliver_later

      redirect_to better_auth.success_session_path
    end

    def success; end

    def confirm
      user = user_class.find_signed(params[:token], purpose: 'passwordless_login')

      if user
        session[:token] = user.signed_id(purpose: 'authentication', expires_in: 1.year)

        redirect_to BetterAuth.configuration.after_sign_in_path, notice: 'Signed in successfully'
      else
        redirect_to better_auth.new_session_path, alert: 'Invalid or expired link'
      end
    end

    def oauth
      auth = request.env['omniauth.auth']
      user = user_class.from_omniauth(auth)

      session[:token] = user.signed_id(purpose: 'authentication', expires_in: 1.year)

      redirect_to BetterAuth.configuration.after_sign_in_path, notice: 'Signed in successfully'
    end

    def destroy
      session[:token] = nil

      redirect_to BetterAuth.configuration.after_sign_out_path, notice: 'You have been logged out!'
    end

    private

    def user_class
      BetterAuth.configuration.user_class.constantize
    end

    def session_params
      params.require(:session).permit(:email)
    end

    def ensure_not_authenticated
      redirect_to BetterAuth.configuration.after_sign_in_path if BetterAuth::Current.user.present?
    end
  end
end
