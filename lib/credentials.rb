class Credentials
  class << self
    def vapid_public_key
      ENV['VAPID_PUBLIC_KEY'] || Rails.application.credentials.vapid_public_key
    end

    def vapid_private_key
      ENV['VAPID_PRIVATE_KEY'] || Rails.application.credentials.vapid_private_key
    end

    def vapid_subject
      ENV['VAPID_SUBJECT'] || Rails.application.credentials.vapid_subject
    end
  end
end
