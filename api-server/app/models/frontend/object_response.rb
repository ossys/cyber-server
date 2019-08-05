# frozen_string_literal: true

module Frontend
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
