# frozen_string_literal: true

module BetterAuth
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :authenticate
      before_action :protect
    end

    private

    def authenticate
      return if request.headers['Authorization'].blank? && session[:token].blank?

      token = session[:token] || request.headers['Authorization'].split(' ').last

      Current.user = User.find_signed(token, purpose: 'authentication')
    end

    def protect
      redirect_to better_auth.new_session_path, error: 'Authentication is required, please login.' unless Current.user.present?
    end
  end
end
