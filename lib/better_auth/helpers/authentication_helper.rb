# frozen_string_literal: true

module BetterAuth
  module Helpers
    module AuthenticationHelper
      def current_user
        BetterAuth::Current.user
      end

      def user_signed_in?
        BetterAuth::Current.user.present?
      end

      def protect!
        authenticate

        redirect_to better_auth.new_session_path, error: 'Authentication is required, please login.' unless user_signed_in?
      end

      def ensure_not_authenticated!
        authenticate

        redirect_to BetterAuth.configuration.after_sign_in_path if user_signed_in?
      end

      private

      def authenticate
        return if request.headers['Authorization'].blank? && session[:token].blank?

        token = session[:token] || request.headers['Authorization'].split(' ').last

        BetterAuth::Current.user = BetterAuth.configuration.user_class.constantize.find_signed(token, purpose: 'authentication')
      end
    end
  end
end
