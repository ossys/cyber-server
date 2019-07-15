# frozen_string_literal: true

module OsQueryApi
  class OsQueryController < ApplicationController
    include RenderHelper

    before_action :check_node_key, except: :enroll
    before_action :set_node_key, except: :enroll

    skip_before_action :authenticate
    wrap_parameters :osq

    def enroll
      if ENV['OSQUERY_ENROLL_SECRET'] == enroll_params[:enroll_secret]
        @node = Node.new
        @node.build_from_params(enroll_params)
      end

      node_invalid = @node&.save
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
      response = { queries: [] }

      if (aql = AdHocQueryList.find_by_node(params))
        aql.queries.each do |q|
          response[:queries] << { q.name => q.body }
        end
        render json: response, status: 200
      else
        render status: 200
      end
    end

    def dist_write
      puts "received dist-write. key: #{dist_write_params[:node_key]}"
      render status: 200
    end

    def log
      puts "received log. key: #{params[:node_key]}, type: #{params[:log_type]}"
      render status: 200
    end

    def test
      render json: { data: 'henlo' }
    end

    private

    def check_node_key
      return if node_key_params[:node_key].present?

      render_error('node_key was not present')
    end

    def set_node_key
      @node_key = node_key_params[:node_key]
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

    def dist_write_params
      params.permit(:node_key, statuses: [{}], queries: {})
    end
  end
end
