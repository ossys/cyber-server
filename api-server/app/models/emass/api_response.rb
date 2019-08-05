# frozen_string_literal: true

module Emass
  class ApiResponse < ActiveModelSerializers::Model
    attributes :meta, :data, :pagination
  end
end
