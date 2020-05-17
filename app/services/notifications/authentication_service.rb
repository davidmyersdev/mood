module Notifications
  class AuthenticationService < BaseService
    class << self
      def notify!(subscription)
        notification = subscription.notifications.create!(
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
        Env.app_url + Rails.application.routes.url_helpers.authenticate_by_notification_ephemeral_index_path
      end
    end
  end
end
