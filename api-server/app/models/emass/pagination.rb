# frozen_string_literal: true

module Emass
  class Pagination < ActiveModelSerializers::Model
    attributes :totalCount, :totalPages, :prevPageUrl, :nextPageUrl
  end
end
