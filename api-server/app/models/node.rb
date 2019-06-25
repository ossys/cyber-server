require 'securerandom'

class Node < ApplicationRecord
  def self.gen_node_key(host)
    host + '-' + SecureRandom.uuid
  end
end
