# -*- encoding : utf-8 -*-
class Admin::MailsController < Admin::BaseController
  
  def index
    @unsent_mail_count = Mail.unsent.count
    @sent_mail_count = Mail.sent.count
  end
  
  def new
    @mail = Mail.new
  end
  
  def to_all
    @mail = Mail.new
    @recipients_caption = "全部会员（共#{Member.approved.count}人）"
    @recipients_type = Mail::RECIPIENTS_TYPE_ALL
    render 'new'
  end
  
  def to_permanent
    @mail = Mail.new
    @recipients_caption = "永久会员（共#{Member.approved.permanent.count}人）"
    @recipients_type = Mail::RECIPIENTS_TYPE_PERMANENT
    render 'new'
  end
  
  def to_council_member
    @mail = Mail.new
    @recipients_type = Mail::RECIPIENTS_TYPE_COUNCIL_MEMBER
    render 'new'
  end
  
  def create
    Mail.bulk_create params[:to], params[:mail][:subject], params[:mail][:content]
    redirect_to admin_mails_path, notice: '邮件批量创建成功！'
  end
  
  def send
    
  end
  
  def clean
    Mail.sent.destroy_all
    redirect_to admin_mails_path, notice: '清空已发送邮件成功！'
  end
end
