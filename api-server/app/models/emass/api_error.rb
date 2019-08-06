# frozen_string_literal: true

module Emass
  class ApiError < ActiveModelSerializers::Model
    attributes :meta
  end
end
