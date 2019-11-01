class JwtService
  class << self
    def encode(payload, exp = 1.week.from_now)
      payload[:exp] = exp.to_i unless payload[:exp].present?

      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      payload, headers = JWT.decode(token, Rails.application.credentials.secret_key_base)

      { payload: payload, headers: headers }.with_indifferent_access
    end
  end
end
