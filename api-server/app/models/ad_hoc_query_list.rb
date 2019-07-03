class AdHocQueryList < ApplicationRecord
  has_and_belongs_to_many :queries, :through => :ad_hoc_query_lists_queries
  has_many :nodes

  def self.build(params)
    queries = []
    nodes = params['nodes']
      .map{ |k| Node.find_by(node_key: k) }
      .compact

    return nil if nodes.empty?

    params['queries'].each do |param|
      query = ::Query.new
      query.name = param['name']
      query.body = param['body']

      query.save!
      queries << query
    end

    data = {
      nodes: nodes,
      queries: queries,
    }

    AdHocQueryList.new(data)
  end

  def as_json(options={})
    { :queries => self.queries }
  end
end
