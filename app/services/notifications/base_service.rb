module Notifications
  class BaseService
    class << self
      private

      def send_it(notification)
        send_it!(notification)
      rescue StandardError => e
        # TODO: handle webpush errors
        # https://github.com/zaru/webpush/blob/c37b3d2f0550367a830da697f87d2d3f85bafddd/lib/webpush/request.rb#L158-L175
        Rails.logger.info('WebPush Error')
        Rails.logger.info(e.inspect)
      end

      def send_it!(notification)
        webpush_send(notification).tap do |response|
          notification.update!(dispatched_at: Time.current) if response.kind_of? Net::HTTPSuccess
        end
      end

      def webpush_send(notification)
        subscription = notification.push_subscription.data.with_indifferent_access

        Webpush.payload_send(
          auth: subscription[:keys][:auth],
          endpoint: subscription[:endpoint],
          message: serialize_notification(notification),
          p256dh: subscription[:keys][:p256dh],
          vapid: {
            private_key: Credentials.vapid_private_key,
            public_key: Credentials.vapid_public_key,
            subject: Credentials.vapid_subject,
          },
        )
      end

      def serialize_notification(notification)
        JSON.generate(
          notification.attributes.with_indifferent_access.slice(
            :data,
            :id,
            :nonce,
          )
        )
      end
    end
  end
end
