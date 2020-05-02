desc 'Send a Mood notification to all subscribers'
task notify_subscribers: :environment do
  PushSubscription.all.each do |subscription|
    # safeguard against accidental, successive notifications
    next if subscription.last_successful_notification&.dispatched_after?(1.hour.ago)

    Notifications::MoodService.notify(subscription)
  end
end
