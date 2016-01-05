# -*- encoding : utf-8 -*-
class Admin::IndividualMembersController < Admin::BaseController
  
  def index
    @individual_members = IndividualMember.sorted.paginate page: params[:page]
  end
  
  def show
    @individual_member = IndividualMember.find(params[:id])
  end
  
  def new
    @individual_member = IndividualMember.new
    @contact = @individual_member.contacts.new
  end
  
  def edit
    @individual_member = IndividualMember.find(params[:id])
    @contact = @individual_member.contacts.first
    @recipients = @individual_member.recipients
  end
  
  def create
    @individual_member = IndividualMember.new(params[:individual_member])
    @contact = @individual_member.contacts.new(params[:contact])
    if @individual_member.save and @contact.save
      redirect_to [:admin, @individual_member], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @individual_member = IndividualMember.find(params[:id])
    @contact = @individual_member.contacts.first
    @recipients = params[:recipients].map{|r| Recipient.find(r[0])} if params[:recipients]
    @individual_member.update_attributes(params[:individual_member])
    @contact.update_attributes(params[:contact])
    @recipients = @recipients.each{|ore| ore.update_attributes(params[:recipients][:"#{ore.id}"])} if @recipients
    if @individual_member.errors.any? or @contact.errors.any? or (@recipients and @recipients.map{|r| r.errors.any?}.include?(true))
      @errors_count = @individual_member.errors.count + @contact.errors.count + @recipients.map{|r| r.errors.count}.inject(0){|s, c| s + c}
      render action: 'edit'
    else
      redirect_to [:admin, @individual_member], notice: '更新成功！'
    end
  end
  
  def destroy
    @individual_member = IndividualMember.find(params[:id])
    @individual_member.destroy
    redirect_to admin_individual_members_path
  end
end
