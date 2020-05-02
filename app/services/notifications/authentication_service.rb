module Notifications
  class AuthenticationService < BaseService
    class << self
      def notify!(push_subscription)
        notification = push_subscription.notifications.create!(
          data: {
            actions: [],
            body: 'Tap to automatically sign in on this device.',
            title: 'Mood',
            type: :authentication,
          },
        )

        send_it!(notification)
      end
    end
  end
end
