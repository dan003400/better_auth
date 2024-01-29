# frozen_string_literal: true

require_relative 'better_auth/version'

require 'omniauth-google-oauth2'

require 'better_auth/configuration'
require 'better_auth/helpers/authentication_helper'
require 'better_auth/routing'
require 'better_auth/engine'
require 'better_auth/current'

module BetterAuth
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
