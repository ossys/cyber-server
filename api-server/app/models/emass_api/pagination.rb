# frozen_string_literal: true

module EmassApi
  class Pagination < ActiveModelSerializers::Model
    attributes :totalCount, :totalPages, :prevPageUrl, :nextPageUrl
  end
end
