class Mailer < ActionMailer::Base
  default from: "shihanxuehui@shihan.org.cn"

  def email email
    mail(to: email.recipient, subject: email.subject, content_type: 'text/html', body: email.content)
    email.sent!
  end
end
