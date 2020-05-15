module Notifications
  class MoodService < BaseService
    class << self
      def notify(push_subscription)
        notification = push_subscription.notifications.create!(
          data: {
            actions: [],
            body: 'How are you feeling right now?',
            title: 'Mood',
            url: url,
          },
        )

        send_it(notification)
      end

      private

      def url
        ENV['APP_URL'] + Rails.application.routes.url_helpers.new_entry_path
      end
    end
  end
end
