# frozen_string_literal: true

module Emass
  class Meta < ActiveModelSerializers::Model
    attributes :code, :errorMessage
  end
end
