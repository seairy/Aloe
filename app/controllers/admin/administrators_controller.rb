# -*- encoding : utf-8 -*-
class Admin::AdministratorsController < Admin::BaseController
  
  def index
    @administrators = Administrator.paginate page: params[:page]
  end
  
  def show
    @administrator = Administrator.find(params[:id])
  end
  
  def new
    @administrator = Administrator.new
  end
  
  def edit
    @administrator = Administrator.find(params[:id])
  end
  
  def create
    @administrator = Administrator.new(params[:administrator])
    if @administrator.save
      redirect_to [:admin, @administrator], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @administrator = Administrator.find(params[:id])
    if @administrator.update_attributes(params[:administrator])
      redirect_to [:admin, @administrator], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @administrator = Administrator.find(params[:id])
    @administrator.destroy
    redirect_to admin_administrators_path
  end
end
