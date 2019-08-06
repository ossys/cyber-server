# frozen_string_literal: true

class Test < ApplicationRecord
  validates :attack_name, :result,
            presence: true, allow_blank: false
end
