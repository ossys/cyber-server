# frozen_string_literal: true

module Frontend
  class AdHocResult < ApplicationRecord
    belongs_to :node
    belongs_to :ad_hoc_query
    validates :node_key, :data, presence: true

    def self.last_result_for_node(node_key, time)
      result = AdHocResult
              .where(node_key: node_key)
              .where(created_at: time..Time.current)

      return nil if result.empty?

      result
        .order(created_at: :desc)
        .first
    end
  end
end
