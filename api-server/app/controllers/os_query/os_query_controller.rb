# frozen_string_literal: true

module OsQuery
  class OsQueryController < ApplicationController
    include RenderHelper

    before_action :check_set_node, except: :enroll

    skip_before_action :authenticate

    def enroll
      if ENV['OSQUERY_ENROLL_SECRET'] == enroll_params[:enroll_secret]
        @node = Node.new
        @node.build_from_params(enroll_params)
      end

      node_invalid = @node&.save!
      result = {
        node_key: @node ? @node.node_key : nil,
        node_invalid: node_invalid
      }.reject { |_k, v| v.nil? }

      render json: result, status: 200
    end

    # can't be named `config` due to rails conflict
    def osq_config
      node = Node.from_node_key(node_key_params)
      render json: node.config.data.to_json
    end

    def dist_read
      response = { queries: {} }

      if (aq = @node.pending_adhoc_queries.first)
        aq.queries.each_with_index do |q, i|
          response[:queries]["#{q.name}-#{i}-#{aq.id}"] = q.body
        end
        render json: response, status: 200
      else
        render status: 200
      end
    end

    def dist_write
      results = {}
      statuses = dist_write_params[:statuses].to_h
      queries = dist_write_params[:queries].to_h

      statuses.each do |k, v|
        name, _, id = k.split("-")

        results[id] = {} if results[id].nil?
        results[id][:queries] = {} if results[id][:queries].nil?
        results[id][:statuses] = {} if results[id][:statuses].nil?

        results[id][:queries][k] = queries[k]
        results[id][:statuses][k] = v
      end

      results.each do |ad_hoc_query_id, values|
        ad_hoc_query = AdHocQuery.find(ad_hoc_query_id)
        unless ad_hoc_query.completed
          node = Node.find_by(node_key: @node_key)
          data = { queries: values[:queries], statuses: values[:statuses] }
          ahqr = AdHocResult.new(
            ad_hoc_query: ad_hoc_query, node: node, node_key: @node_key, data: data)
          if ahqr.save && ad_hoc_query.is_complete?
            ad_hoc_query.completed = true
            ad_hoc_query.save!
          end
        end
      end
    end

    def log
      puts "received log. key: #{params[:node_key]}, type: #{params[:log_type]}"
      render status: 200
    end

    def test
      render json: { data: 'henlo' }
    end

    private

    def check_set_node
      if node_key_params[:node_key].present?
        if Node.find_by(node_key: node_key_params[:node_key])
          @node_key = node_key_params[:node_key]
          @node = Node.find_by(node_key: @node_key)
          return
        else
          return render status: 200, json: { "node_invalid": true }
        end
      end

      render_error('node_key was not present')
    end

    def enroll_params
      params.permit(
        :enroll_secret,
        :host_identifier,
        :platform_type,
        host_details: [
          os_version: {},
          osquery_info: {},
          system_info: {},
          platform_info: {}
        ]
      )
    end

    def node_key_params
      params.permit(:node_key)
    end

    def log_params
      params.permit(:node_key, :log_type, data: [{}])
    end

    def dist_read_params
      params.permit(:node_key)
    end

    def dist_write_params
      params.permit(:node_key, statuses: {}, queries: {})
    end
  end
end
