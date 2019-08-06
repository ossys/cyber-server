# frozen_string_literal: true

module Frontend
  class ApiError
    attr_accessor :errors

    def initialize(errors)
      @errors = errors
    end
  end

  class SerializableApiError < JSONAPI::Serializable::Resource
    attributes :errors
  end
end
