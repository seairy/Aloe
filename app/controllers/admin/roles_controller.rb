# -*- encoding : utf-8 -*-
class Admin::RolesController < Admin::BaseController
  
  def index
    @roles = Role.paginate page: params[:page]
  end
  
  def show
    @role = Role.find(params[:id])
  end
  
  def new
    @role = Role.new
  end
  
  def edit
    @role = Role.find(params[:id])
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to [:admin, @role], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to [:admin, @role], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to admin_roles_path
  end
end
