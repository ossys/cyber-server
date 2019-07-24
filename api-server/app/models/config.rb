# frozen_string_literal: true

class Config < ApplicationRecord
  has_many :nodes

  validates :name, :data, presence: true
end
