class NotificationService
  class << self
    def send(message, subscription)
      Webpush.payload_send(
        auth: subscription[:keys][:auth],
        endpoint: subscription[:endpoint],
        message: message,
        p256dh: subscription[:keys][:p256dh],
        vapid: {
          private_key: Rails.application.credentials.vapid_private_key,
          public_key: Rails.application.credentials.vapid_public_key,
          subject: Rails.application.credentials.vapid_subject,
        },
      )
    end
  end
end
