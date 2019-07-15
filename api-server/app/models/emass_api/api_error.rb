# frozen_string_literal: true

module EmassApi
  class ApiError < ActiveModelSerializers::Model
    attributes :meta
  end
end
