desc 'send mail if message is unread'
task send_email_if_msg: :environment do
  @unreadmessagesSender = Message.where(senderclick: false).pluck(:sender).uniq
  @senderUsers = User.where(id: @unreadmessagesSender, emailmsgnotification: nil).uniq.each do |su|
    next if su.email.blank?
    UserMailer.msg_notification_email(su).deliver_now
  end

  @unreadmessagesRecipent = Message.where(recipentclick: false).pluck(:recipent).uniq
  @recipentUsers = User.where(id: @unreadmessagesRecipent, emailmsgnotification: nil).uniq.each do |ru|
    next if su.email.blank?
    UserMailer.msg_notification_email(ru).deliver_now
  end
end
