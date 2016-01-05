# -*- encoding : utf-8 -*-
class Admin::PermissionsController < Admin::BaseController
  before_filter :find_role
  
  def show
    @permission = Permission.find(params[:id])
  end
  
  def new
    @permission = Permission.new
  end
  
  def edit
    @permission = Permission.find(params[:id])
  end
  
  def create
    @permission = Permission.new(params[:permission])
    @permission.role = @role
    if @permission.save
      redirect_to [:admin, @role], notice: '特殊权限创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @permission = Permission.find(params[:id])
    if @permission.update_attributes(params[:permission])
      redirect_to [:admin, @role], notice: '特殊权限更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @permission = @role.permissions.find(params[:id])
    @permission.destroy
    redirect_to [:admin, @role], notice: '特殊权限删除成功！'
  end
  
  protected
  def find_role
    @role = Role.find(params[:role_id])
  end
end
