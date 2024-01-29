# frozen_string_literal: true

module BetterAuth
  class Engine < ::Rails::Engine
    isolate_namespace BetterAuth

    initializer 'better_auth.add_routing_methods' do
      ActionDispatch::Routing::Mapper.include BetterAuth::Routing::MapperExtensions
    end

    initializer 'better_auth.action_controller' do
      ActiveSupport.on_load(:action_controller) do
        include BetterAuth::Helpers::AuthenticationHelper

        helper_method :current_user
      end
    end

    initializer 'better_auth.omniauth', before: :build_middleware_stack do |app|
      if BetterAuth.configuration.google_client_id && BetterAuth.configuration.google_client_secret
        OmniAuth.config.path_prefix = '/oauth'
        OmniAuth.config.logger = Rails.logger
        OmniAuth.config.allowed_request_methods = %i[get]

        app.middleware.use OmniAuth::Builder do
          provider :google_oauth2, BetterAuth.configuration.google_client_id, BetterAuth.configuration.google_client_secret, {
            provider_ignores_state: true,
            prompt: 'select_account',
            callback_path: "#{BetterAuth.configuration.mount_path}/oauth/google_oauth2/callback"
          }
        end
      end
    end
  end
end
