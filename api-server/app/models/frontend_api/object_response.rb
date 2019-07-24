# frozen_string_literal: true

module FrontendApi
  class ObjectResponse
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    def id
      0
    end
  end
end
