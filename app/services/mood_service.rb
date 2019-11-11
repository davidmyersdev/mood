class MoodService
  class << self
    def notify(push_subscription)
      notification = push_subscription.notifications.create!(
        data: {
          actions: actions(push_subscription.max_actions),
          body: 'How are you feeling right now?',
          title: 'Mood',
        },
      )

      NotificationService.send(notification)
    end

    private

    def actions(max_actions)
      case max_actions
      when 2
        [happy, upset]
      when 3
        [happy, meh, upset]
      when 4
        [happy, meh, sad, upset]
      else
        []
      end
    end

    def happy
      @happy ||= serialize_action(Mood.happy)
    end

    def meh
      @meh ||= serialize_action(Mood.meh)
    end

    def sad
      @sad ||= serialize_action(Mood.sad)
    end

    def upset
      @upset ||= serialize_action(Mood.upset)
    end

    def serialize_action(mood)
      {
        action: mood.slug,
        title: mood.description,
      }
    end
  end
end
