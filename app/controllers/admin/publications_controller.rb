# -*- encoding : utf-8 -*-
class Admin::PublicationsController < Admin::BaseController
  
  def index
    @publications = Publication.paginate page: params[:page]
  end
  
  def show
    @publication = Publication.find(params[:id])
  end
  
  def new
    @publication = Publication.new
  end
  
  def edit
    @publication = Publication.find(params[:id])
  end
  
  def create
    @publication = Publication.new(params[:publication])
    if @publication.save
      redirect_to [:admin, @publication], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(params[:publication])
      redirect_to [:admin, @publication], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @publication = Publication.find(params[:id])
    if @publication.volumes.count > 0
      redirect_to [:admin, @publication], alert: '删除失败！请先删除所有期刊！'
    else
      @publication.destroy
      redirect_to admin_publications_path
    end
  end
end
