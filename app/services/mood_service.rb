class MoodService
  class << self
    def notify(push_subscription)
      message = {
        actions: actions(push_subscription.max_actions),
        body: 'How are you feeling right now?',
        title: 'Mood',
      }

      NotificationService.send(message, push_subscription.subscription.with_indifferent_access)
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
      {
        action: 'happy',
        title: '🙂 Happy',
      }.freeze
    end

    def meh
      {
        action: 'meh',
        title: '😕 Meh',
      }.freeze
    end

    def sad
      {
        action: 'sad',
        title: '😞 Sad',
      }.freeze
    end

    def upset
      {
        action: 'upset',
        title: '😠 Upset',
      }.freeze
    end
  end
end
