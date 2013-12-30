# -*- encoding : utf-8 -*-
class Admin::PublicationCategoriesController < Admin::BaseController
  before_filter :find_publication_volume, only: [:new, :create]
  
  def new
    @publication_category = PublicationCategory.new
  end
  
  def edit
    @publication_category = PublicationCategory.find(params[:id])
  end
  
  def create
    @publication_category = PublicationCategory.new(params[:publication_category])
    @publication_category.volume = @publication_volume
    if @publication_category.save
      redirect_to [:admin, @publication_volume], notice: '分类创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @publication_category = PublicationCategory.find(params[:id])
    if @publication_category.update_attributes(params[:publication_category])
      redirect_to [:admin, @publication_category.volume], notice: '分类更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @publication_category = PublicationCategory.find(params[:id])
    if @publication_category.articles.count > 0
      redirect_to [:admin, @publication_category.volume], alert: '分类删除失败！请先删除所有文章！'
    else
      @publication_category.destroy
      redirect_to [:admin, @publication_category.volume]
    end
  end
  
  protected
  def find_publication_volume
    @publication_volume = PublicationVolume.find params[:publication_volume_id]
  end
end
