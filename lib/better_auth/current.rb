# frozen_string_literal: true

module BetterAuth
  class Current < ActiveSupport::CurrentAttributes
    attribute :user
  end
end
