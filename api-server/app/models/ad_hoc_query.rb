# frozen_string_literal: true

class AdHocQuery < ApplicationRecord
  has_and_belongs_to_many :queries, through: :ad_hoc_queries_queries
  has_and_belongs_to_many :nodes, through: :ad_hoc_queries_nodes

  def self.from_query(node_key, query_name, query_body)
    node = Node.find_by(node_key: node_key)
    return nil if node.nil?

    query = ::Query.new(name: query_name, body: query_body)
    query.save!

    AdHocQuery.new(nodes: [node], queries: [query])
  end

  def self.build(params)
    queries = []
    nodes = params['nodes']
            .map { |k| Node.find_by(node_key: k) }
            .compact

    return nil if nodes.empty?

    params['queries'].each do |param|
      query = ::Query.new
      query.name = param['name']
      query.body = param['body']

      query.save!
      queries << query
    end

    AdHocQuery.new(nodes: nodes, queries: queries)
  end

  def self.find_list(node_key)
    AdHocQuery
      .includes(:nodes)
      .joins(:nodes)
      .where('nodes.node_key = ?', node_key)
      .where(has_run: false)
      .first
  end

  def as_json(_options = {})
    {
      id: id,
      has_run: has_run,
      queries: queries,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
