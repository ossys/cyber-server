module Frontend
  class SerializableUser < JSONAPI::Serializable::Resource
    type 'users'

    attributes :id, :email, :created_at, :updated_at
  end
end
