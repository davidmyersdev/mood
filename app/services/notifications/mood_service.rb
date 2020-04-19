module Notifications
  class MoodService < BaseService
    class << self
      def notify(push_subscription)
        notification = push_subscription.notifications.create!(
          data: {
            actions: [],
            body: 'How are you feeling right now?',
            title: 'Mood',
          },
        )

        send_it(notification)
      end
    end
  end
end
