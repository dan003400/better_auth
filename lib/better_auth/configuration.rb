# frozen_string_literal: true

module BetterAuth
  class Configuration
    attr_accessor :user_class, :mailer_from, :after_sign_in_path, :after_sign_out_path

    def initialize
      @user_class = 'User'
      @mailer_from = 'no-reply@example.com'
      @after_sign_in_path = '/'
      @after_sign_out_path = '/'
    end
  end
end
