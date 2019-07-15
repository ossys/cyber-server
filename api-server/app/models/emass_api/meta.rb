# frozen_string_literal: true

module EmassApi
  class Meta < ActiveModelSerializers::Model
    attributes :code, :errorMessage
  end
end
