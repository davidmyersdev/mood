class Env
  class << self
    def app_url
      ENV['APP_URL'].presence
    end

    def secret_key_base
      ENV['SECRET_KEY_BASE'].presence || Rails.application.credentials.secret_key_base
    end

    def vapid_public_key
      ENV['VAPID_PUBLIC_KEY'].presence || Rails.application.credentials.vapid_public_key
    end

    def vapid_private_key
      ENV['VAPID_PRIVATE_KEY'].presence || Rails.application.credentials.vapid_private_key
    end

    def vapid_subject
      ENV['VAPID_SUBJECT'].presence || Rails.application.credentials.vapid_subject
    end
  end
end
