class Query < ApplicationRecord
  has_and_belongs_to_many :ad_hoc_query_lists
end
