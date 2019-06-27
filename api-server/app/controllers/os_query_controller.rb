# frozen_string_literal: true

class OsQueryController < ApplicationController
  #before_filter :verify_node, only: [:config, :dist_read, :dist_write, :log]

  def enroll
    @node = Node.new
    @node.set_fields(params[:os_query])
    @node.config = Config.first

    node_invalid = if @node.valid? && @node.save
                     false
                   else
                     true
                   end

    result = {
      :node_key => @node.key,
      :node_invalid => node_invalid
    }.reject{ |k, v| v.nil? }

    render :json => result
  end

  # can't be named `config` due to rails conflict
  def osq_config
    p params[:config][:node_key]
    @config = Config.find_by(key: params[:config][:node_key])
  end

  def dist_read
  end

  def dist_write
  end

  def log
  end

  def test
    render :json => { :data => 'henlo' }
  end

  private

  def verify_node
  end

  def enroll_params
    params.require(:os_query).permit(
      :enroll_secret,
      :host_identifier,
      :platform_type,
      :host_details => [
        :os_version => {},
        :osquery_info => {},
        :system_info => {}
      ]
    )
  end

  def config_params
    params.require(:config).permit(:node_key)
  end
end
