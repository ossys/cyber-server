# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def to_json(options = {})
    options[:except] ||= %i[
      encrypted_password
      password_salt
      password_digest
    ]

    super(options)
  end
end
