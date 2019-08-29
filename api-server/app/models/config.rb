# frozen_string_literal: true

class Config < ApplicationRecord
  has_many :nodes
  validates :name, :data, presence: true

  def self.for_os(os_name)
    platform = os_name.downcase

    if name.include?('windows')
      Config.find(2)
    elsif name.include?('mac')
      Config.find(3)
    elsif name.include?('bsd')
      Config.find(4)
    else
      Config.find(1)
    end
  end
end
