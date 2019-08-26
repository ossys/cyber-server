# frozen_string_literal: true

class Query < ApplicationRecord
  has_and_belongs_to_many :ad_hoc_queries, through: :ad_hoc_queries_queries
end
