# frozen_string_literal: true

module BetterAuth
  module Routing
    module MapperExtensions
      def better_auth_for(_model, options = {})
        mount BetterAuth::Engine => options.fetch(:path, '/auth')

        BetterAuth.configuration.mount_path_proc = -> { options.fetch(:path, '/auth') }
      end
    end
  end
end
