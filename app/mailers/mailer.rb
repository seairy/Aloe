class Mailer < ActionMailer::Base
  default from: "shihanxuehui@shihan.org.cn"

  def email email
    mail(to: email.recipient, subject: email.subject){|format| format.html { render text: email.content }}
    email.sent!
  end
end
