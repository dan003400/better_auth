# frozen_string_literal: true

module BetterAuth
  class Configuration
    attr_accessor :user_class, :mailer_from, :after_sign_in_path, :after_sign_out_path, :google_client_id, :google_client_secret, :mount_path_proc

    def initialize
      @user_class = 'User'
      @mailer_from = 'no-reply@example.com'

      @after_sign_in_path = '/'
      @after_sign_out_path = '/'

      @google_client_id = nil
      @google_client_secret = nil
    end

    def mount_path
      @mount_path ||= mount_path_proc&.call || '/auth'
    end
  end
end
