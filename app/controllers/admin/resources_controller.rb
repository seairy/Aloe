# -*- encoding : utf-8 -*-
class Admin::ResourcesController < Admin::BaseController
  
  def index
    @resources = Resource.paginate page: params[:page]
  end
  
  def show
    @resource = Resource.find(params[:id])
  end
  
  def new
    @resource = Resource.new
  end
  
  def edit
    @resource = Resource.find(params[:id])
  end
  
  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      redirect_to [:admin, @resource], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      redirect_to [:admin, @resource], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to admin_resources_path
  end
end
