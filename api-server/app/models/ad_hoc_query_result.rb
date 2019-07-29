class AdHocQueryResult < ApplicationRecord
  belongs_to :node, foreign_key: 'node_key', primary_key: 'node_key'

  validates :node_key, :data, presence: true
end
