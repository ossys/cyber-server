class AdHocQueryList < ApplicationRecord
  has_and_belongs_to_many :queries
  has_many :nodes

  def self.build(params)
    queries = []
    nodes = params['nodes']
      .flat_map{ |k| Node.find_by(key: k) }

    params['queries'].each do |param|
      query = ::Query.new
      query.name = param['name']
      query.body = param['query']

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
