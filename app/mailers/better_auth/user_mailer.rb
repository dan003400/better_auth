# frozen_string_literal: true

module BetterAuth
  class UserMailer < ActionMailer::Base
    default from: -> { BetterAuth.configuration.mailer_from }

    def magic_link(user)
      token = user.signed_id(purpose: 'passwordless_login', expires_in: 15.minutes)

      @confirm_url = better_auth.confirm_session_url(token: token)

      mail to: user.email, subject: 'Your Magic Link'
    end
  end
end
