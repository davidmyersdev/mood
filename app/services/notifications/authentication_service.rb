module Notifications
  class AuthenticationService < BaseService
    class << self
      def notify!(push_subscription)
        notification = push_subscription.notifications.create!(
          data: {
            actions: [],
            body: 'Tap to automatically sign in on this device.',
            title: 'Mood',
            url: url,
          },
        )

        send_it!(notification)
      end

      private

      def url
        ENV['APP_URL'] + Rails.application.routes.url_helpers.authenticate_by_notification_ephemeral_index_path
      end
    end
  end
end
