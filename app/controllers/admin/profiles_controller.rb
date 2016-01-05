# -*- encoding : utf-8 -*-
class Admin::ProfilesController < Admin::BaseController
  
  def edit
    @administrator = Administrator.find(session[:administrator][:id])
  end
  
  def update
    @administrator = Administrator.find(session[:administrator][:id])
    if @administrator.update_attributes(params[:administrator])
      session[:administrator][:name] = @administrator.name
      redirect_to edit_admin_profile_path, notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def update_password
    administrator = Administrator.find(session[:administrator][:id])
    if not administrator.authenticate(params[:orginal_password])
      redirect_to edit_password_admin_profile_path, alert: '修改失败！原密码不正确！'
    elsif not /^[A-Za-z0-9]{6,16}$/ =~ params[:new_password]
      redirect_to edit_password_admin_profile_path, alert: '修改失败！新密码应由6至16位的大小写字母及数字组成，请重试！'
    elsif not params[:new_password] == params[:confirmd_password]
      redirect_to edit_password_admin_profile_path, alert: '修改失败！两次新密码输入不一致！'
    else
      administrator.password = params[:new_password]
      administrator.password_confirmation = params[:new_password]
      administrator.save
      redirect_to edit_password_admin_profile_path, notice: '修改成功！'
    end
  end
end
