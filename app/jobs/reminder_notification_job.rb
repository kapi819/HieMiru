# frozen_string_literal: true

# ReminderNotificationJob is responsible for sending reminder notifications to users.
# This job is typically scheduled to run periodically to remind users about their tasks or goals.

class ReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      next unless user.goals.exists?

      reminder_message = generate_reminder_message(user)
      LineNotifyService.send_message(user.uid, reminder_message) if user.uid.present?
    end
  end

  private

  def generate_reminder_message(user)
    goals_summary = user.goals.map do |goal|
      "目標: #{goal.goal_body}, 達成回数: #{goal.count}"
    end.join("\n")
    
    "こんにちは、#{user.name}さん。現在、以下の目標を達成しています！\n#{goals_summary}\n来週も継続して目標を達成しましょう。"
  end
end
