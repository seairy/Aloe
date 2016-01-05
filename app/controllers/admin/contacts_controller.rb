# -*- encoding : utf-8 -*-
class Admin::ContactsController < Admin::BaseController
  before_filter :find_member, only: %w{new create}
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    @contact.member = @member
    if @contact.save
      redirect_to [:admin, @member], notice: '联系人创建成功！'
    else
      render action: 'new'
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to [:admin, @contact.member]
  end
  
  protected
  def find_member
    @member = Member.find(params[:individual_member_id] || params[:organization_member_id])
  end
end
