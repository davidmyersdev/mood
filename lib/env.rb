class Env
  class << self
    def app_url
      ENV['APP_URL'].presence
    end

    def secret_key_base
      ENV['SECRET_KEY_BASE'].presence || Rails.application.credentials.secret_key_base.presence
    end

    def sentry_client_dsn
      ENV['SENTRY_CLIENT_DSN'].presence
    end

    def sentry_server_dsn
      ENV['SENTRY_DSN'].presence
    end

    def time_zone
      ENV['RAILS_TIME_ZONE'].presence || Rails.configuration.time_zone.presence
    end

    def vapid_public_key
      ENV['VAPID_PUBLIC_KEY'].presence || Rails.application.credentials.vapid_public_key.presence
    end

    def vapid_private_key
      ENV['VAPID_PRIVATE_KEY'].presence || Rails.application.credentials.vapid_private_key.presence
    end

    def vapid_subject
      ENV['VAPID_SUBJECT'].presence || Rails.application.credentials.vapid_subject.presence
    end
  end
end
