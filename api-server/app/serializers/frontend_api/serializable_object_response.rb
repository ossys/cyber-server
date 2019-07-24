module FrontendApi
  class SerializableObjectResponse < JSONAPI::Serializable::Resource
    type 'ObjectResponse'

    attribute :value
  end
end
