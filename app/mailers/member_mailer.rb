# -*- encoding : utf-8 -*-
class MemberMailer < ActionMailer::Base
  default from: "shihanxuehui@shihan.org.cn"
  
  def welcome recipient, member
    @member = member
    mail(to: recipient, subject: '欢迎加入世界汉语教学学会')
  end
  
  def newsletter recipient, newsletter
    @newsletter = newsletter
    mail(to: recipient, subject: "《#{newsletter.name}》正式发布！")
  end
  
  def customized recipient, subject, content
    @content = content
    mail(to: recipient, subject: subject)
  end
end
