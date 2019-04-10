desc 'send test mail'
task send_test_email: :environment do
  user = User.first
  UserMailer.msg_notification_email(user).deliver_now
end
