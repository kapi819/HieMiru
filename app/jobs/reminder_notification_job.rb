class ReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
    # 全ユーザーを対象にリマインダー通知を送信する
      next unless user.receive_reminder_notifications
      # ユーザーが通知を受け取る設定になっているかチェック
      reminder_message = generate_reminder_message(user)
      # 通知メッセージをカスタマイズ
      LineNotifyService.send_message(user.uid, reminder_message) if user.uid.present?
      # LINE通知サービスを使用してリマインダーを送信
    end
  end

  private

  def generate_reminder_message(user)
    "こんにちは、#{user.name}さん。今日のタスクを忘れずにチェックしてくださいね！"
  end
end