# frozen_string_literal: true

# ReminderNotificationJob is responsible for sending reminder notifications to users.
# This job is typically scheduled to run periodically to remind users about their tasks or goals.

class ReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      # 全ユーザーを対象にリマインダー通知を送信する
      next unless user.goals.exists?

      # ユーザーが目標を持っているかチェック
      reminder_message = generate_reminder_message(user)
      # 通知メッセージをカスタマイズ
      LineNotifyService.send_message(user.uid, reminder_message) if user.uid.present?
      # LINE通知サービスを使用してリマインダーを送信
    end
  end

  private

  def generate_reminder_message(user)
    "こんにちは、#{user.name}さん。今週のタスクを忘れずにチェックしてくださいね！"
  end
end
