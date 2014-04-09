# -*- encoding : utf-8 -*-
class MembersController < BaseController
  before_filter :authenticate
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

  def update_password
    @member = Member.find session[:member][:id]
    if params[:password] != params[:password_confirmation]
      flash[:alert] = '两次密码输入不一致，请重试'
    elsif @member.hashed_password != Digest::MD5.hexdigest(params[:original_password])
      flash[:alert] = '原密码输入不正确，请重试'
    else
      @member.hashed_password = Digest::MD5.hexdigest(params[:password])
      @member.save
      flash[:notice] = '密码修改成功'
    end
    redirect_to edit_password_member_path
  end
  
  protected
  def set_location
    extend_location_chain '会员信息'
  end
end
