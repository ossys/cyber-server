# frozen_string_literal: true

module EmassApi
  class ApiResponse < ActiveModelSerializers::Model
    attributes :meta, :data, :pagination
  end
end
