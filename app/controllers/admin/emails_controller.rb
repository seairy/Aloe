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

  def to_emaillist
    @email = Email.new
    emaillist = Emaillist.find params[:emaillist_id]
    @recipients_caption = "#{emaillist.name}（共#{emaillist.recipients.count}人）"
    @recipients_type = Email::RECIPIENTS_TYPE_EMAILLIST
    @recipients_value = params[:emaillist_id]
    render 'new'
  end

  def to
    @email = Email.new
    @recipients_caption = "会员#{Member.find(params[:member_id]).chinese_name}"
    @recipients_type = Email::RECIPIENTS_TYPE_MEMBER
    @recipients_value = params[:member_id]
    render 'new'
  end
  
  def create
    Email.bulk_create params[:recipients_type], params[:recipients_value], params[:email][:subject], params[:email][:content]
    redirect_to admin_emails_path, notice: '邮件创建成功！'
  end
  
  def send_mails
    
  end
  
  def clean_sent
    Email.sent.destroy_all
    redirect_to admin_emails_path, notice: '清空已发送邮件成功！'
  end

  def clean_unsent
    Email.unsent.destroy_all
    redirect_to admin_emails_path, notice: '清空未发送邮件成功！'
  end
end
