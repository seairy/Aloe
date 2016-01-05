# -*- encoding : utf-8 -*-
class Admin::RecipientsController < Admin::BaseController
  before_filter :find_member, only: %w{new create}
  
  def new
    @recipient = Recipient.new
  end
  
  def create
    @recipient = Recipient.new(params[:recipient])
    @recipient.member = @member
    if @recipient.save
      redirect_to [:admin, @member], notice: '邮箱创建成功！'
    else
      render action: 'new'
    end
  end
  
  def destroy
    @recipient = Recipient.find(params[:id])
    @recipient.destroy
    redirect_to [:admin, @recipient.member]
  end
  
  def duplicated
    @recipients = Recipient.duplicated
  end
  
  def clean_duplicated
    Recipient.clean_duplicated!
    redirect_to duplicated_admin_recipients_path, notice: '清除成功！'
  end
  
  protected
  def find_member
    @member = Member.find(params[:individual_member_id] || params[:organization_member_id])
  end
end
