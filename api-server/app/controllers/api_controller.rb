class ApiController < ApplicationController
  #before_filter :verify_node, only: [:config, :dist_read, :dist_write, :log]

  def enroll
    new_params = enroll_params
    uuid = Node.gen_node_key()
    p new_params
  end

  def config
  end

  def dist_read
  end

  def dist_write
  end
  
  def log
  end

  private

  def verify_node
  end

  def enroll_params
    params.require(:data).permit(:enroll_secret, :host_identifier, :host_details)
  end
end
