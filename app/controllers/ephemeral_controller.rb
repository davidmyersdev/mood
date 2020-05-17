class EphemeralController < ApplicationController
  def notify_me
    current_user.subscriptions.kept.find_each do |subscription|
      Notifications::MoodService.notify(subscription)
    end

    redirect_to dashboard_index_path
  end
end
