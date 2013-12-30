# -*- encoding : utf-8 -*-
class MembersController < BaseController
  before_filter :set_location
  
  def edit
    extend_location_chain '修改信息'
    @member = Member.find session[:member][:id]
    render (@member.individual? ? 'edit_individual_member' : 'edit_organization_member')
  end
  
  def update
    extend_location_chain '修改信息'
    @member = Member.find session[:member][:id]
    if @member.individual?
      if @member.update_attributes(params[:individual_member]) and @member.contacts.first.update_attributes(params[:contact])
        redirect_to edit_member_path, notice: '更新成功！'
      else
        render action: 'edit'
      end
    else
      
    end
  end
  
  protected
  def set_location
    extend_location_chain '会员信息'
  end
end
