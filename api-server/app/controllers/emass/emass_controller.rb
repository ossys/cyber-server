# frozen_string_literal: true

require 'securerandom'

module Emass
  class EmassController < EmassApplicationController
    def status
      render_data('success' => true)
    end

    def register
      render_data('api-key' => SecureRandom.uuid)
    end
  end
end
