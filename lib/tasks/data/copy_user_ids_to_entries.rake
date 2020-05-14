namespace :data do
  desc 'Copy User ids from Notification to Entry'
  task copy_user_ids_to_entries: :environment do
    Entry.all.find_each do |entry|
      next if entry.user
      next unless entry.notification&.user

      # going forward, we will be able to get all user entries directly from the user
      entry.update!(user: entry.notification.user)
    end
  end
end
