require 'jwt'

class Auth
  ALGORITHM = 'HS256'

  def self.exp_payload(payload)
    expiration = Time.now.to_i + 4 * 86400

    { data: payload, exp: expiration }
  end

  def self.issue(payload)
    JWT.encode(
      Auth.exp_payload(payload),
      auth_secret,
      ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(
      token,
      auth_secret,
      true,
      { algorithm: ALGORITHM }
    )
  end

  def self.auth_secret
    ENV['DEVISE_JWT_SECRET_KEY']
  end
end
