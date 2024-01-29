# frozen_string_literal: true

module BetterAuth
  module Routing
    module MapperExtensions
      def better_auth_for(model, options = {})
        model_class = model.to_s.classify

        BetterAuth.configuration.user_class = model_class
        BetterAuth.configuration.mount_path_proc = -> { options.fetch(:path, '/auth') }

        mount BetterAuth::Engine => options.fetch(:path, '/auth')
      end
    end
  end
end
