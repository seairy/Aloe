# -*- encoding : utf-8 -*-
class Admin::PublicationVolumesController < Admin::BaseController
  before_filter :find_publication, only: [:new, :create]
  
  def show
    @publication_volume = PublicationVolume.find(params[:id])
  end
  
  def new
    @publication_volume = PublicationVolume.new
  end
  
  def edit
    @publication_volume = PublicationVolume.find(params[:id])
  end
  
  def create
    @publication_volume = PublicationVolume.new(params[:publication_volume])
    @publication_volume.publication = @publication
    if @publication_volume.save
      redirect_to [:admin, @publication_volume], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @publication_volume = PublicationVolume.find(params[:id])
    if @publication_volume.update_attributes(params[:publication_volume])
      redirect_to [:admin, @publication_volume], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @publication_volume = PublicationVolume.find(params[:id])
    if @publication_volume.categories.count > 0
      redirect_to [:admin, @publication_volume], alert: '期刊删除失败！请先删除所有分类！'
    else
      @publication_volume.destroy
      redirect_to [:admin, @publication_volume.publication]
    end
  end
  
  protected
  def find_publication
    @publication = Publication.find params[:publication_id]
  end
end
