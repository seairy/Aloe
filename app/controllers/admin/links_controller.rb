# -*- encoding : utf-8 -*-
class Admin::LinksController < Admin::BaseController
  
  def index
    @links = Link.paginate page: params[:page]
  end
  
  def show
    @link = Link.find(params[:id])
  end
  
  def new
    @link = Link.new
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to [:admin, @link], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to [:admin, @link], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to admin_links_path
  end
end
