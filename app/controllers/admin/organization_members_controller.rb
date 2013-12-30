# -*- encoding : utf-8 -*-
class Admin::OrganizationMembersController < Admin::BaseController
  
  def index
    @organization_members = OrganizationMember.sorted.paginate page: params[:page]
  end
  
  def show
    @organization_member = OrganizationMember.find(params[:id])
  end
  
  def new
    @organization_member = OrganizationMember.new
  end
  
  def edit
    @organization_member = OrganizationMember.find(params[:id])
    @contacts = @organization_member.contacts
    @recipients = @organization_member.recipients
  end
  
  def create
    @organization_member = OrganizationMember.new(params[:organization_member])
    if @organization_member.save
      redirect_to [:admin, @organization_member], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @organization_member = OrganizationMember.find(params[:id])
    @contacts = params[:contacts].map{|r| Contact.find(r[0])}
    @recipients = params[:recipients].map{|r| Recipient.find(r[0])}
    @organization_member.update_attributes(params[:organization_member])
    @contacts = @contacts.each{|oc| oc.update_attributes(params[:contacts][:"#{oc.id}"])}
    @recipients = @recipients.each{|ore| ore.update_attributes(params[:recipients][:"#{ore.id}"])}
    if @organization_member.errors.any? or @contacts.map{|c| c.errors.any?}.include?(true) or @recipients.map{|r| r.errors.any?}.include?(true)
      @errors_count = @organization_member.errors.count + @contacts.map{|c| c.errors.count}.inject(0){|s, c| s + c} + @recipients.map{|r| r.errors.count}.inject(0){|s, c| s + c}
      render action: 'edit'
    else
      redirect_to [:admin, @organization_member], notice: '更新成功！'
    end
  end
  
  def destroy
    @organization_member = OrganizationMember.find(params[:id])
    @organization_member.destroy
    redirect_to admin_organization_members_path
  end
end
