# frozen_string_literal: true

class AdHocQueryResult < ApplicationRecord
  belongs_to :node, foreign_key: 'node_key', primary_key: 'node_key'

  validates :node_key, :data, presence: true

  def self.last_result_for_node(node_key, time)
    result = AdHocQueryResult
             .where(node_key: node_key)
             .where(created_at: time..Time.current)

    return nil if result.empty?

    result
      .order(created_at: :desc)
      .first
  end
end
