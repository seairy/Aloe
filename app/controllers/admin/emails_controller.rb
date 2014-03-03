# -*- encoding : utf-8 -*-
class Admin::EmailsController < Admin::BaseController
  
  def index
    @unsent_email_count = Email.unsent.count
    @sent_email_count = Email.sent.count
  end
  
  def new
    @email = Email.new
  end
  
  def to_all
    @email = Email.new
    @recipients_caption = "全部会员（共#{Member.approved.count}人）"
    @recipients_type = Email::RECIPIENTS_TYPE_ALL
    render 'new'
  end
  
  def to_permanent
    @email = Email.new
    @recipients_caption = "永久会员（共#{Member.approved.permanent.count}人）"
    @recipients_type = Email::RECIPIENTS_TYPE_PERMANENT
    render 'new'
  end
  
  def to_council_member
    @email = Email.new
    @recipients_type = Email::RECIPIENTS_TYPE_COUNCIL_MEMBER
    render 'new'
  end

  def to
    @email = Email.new
    @recipients_caption = "会员#{Member.find(params[:member_id]).chinese_name}"
  end
  
  def create
    Email.bulk_create params[:to], params[:email][:subject], params[:email][:content]
    redirect_to admin_emails_path, notice: '邮件批量创建成功！'
  end
  
  def send_mails
    
  end
  
  def clean
    Email.sent.destroy_all
    redirect_to admin_emails_path, notice: '清空已发送邮件成功！'
  end
end
