class NotificationService
  class << self
    def send(notification)
      webpush_send(notification).tap do |response|
        notification.update!(dispatched_at: Time.current) if response.kind_of? Net::HTTPSuccess
      end
    end

    private

    def webpush_send(notification)
      subscription = notification.push_subscription.data.with_indifferent_access

      Webpush.payload_send(
        auth: subscription[:keys][:auth],
        endpoint: subscription[:endpoint],
        message: JSON.generate(notification.data),
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
