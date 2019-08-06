# frozen_string_literal: true

module Frontend
  class SerializableObjectResponse < JSONAPI::Serializable::Resource
    type 'ObjectResponse'

    attribute :value
  end
end
