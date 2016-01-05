# -*- encoding : utf-8 -*-
class Admin::PublicationArticlesController < Admin::BaseController
  before_filter :find_publication_volume, only: [:new, :create]
  
  def show
    @publication_article = PublicationArticle.find(params[:id])
  end
  
  def new
    @publication_article = PublicationArticle.new
  end
  
  def edit
    @publication_article = PublicationArticle.find(params[:id])
  end
  
  def create
    @publication_article = PublicationArticle.new(params[:publication_article])
    if @publication_article.save
      redirect_to [:admin, @publication_article.category.volume], notice: '文章创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @publication_article = PublicationArticle.find(params[:id])
    if @publication_article.update_attributes(params[:publication_article])
      redirect_to [:admin, @publication_article.category.volume], notice: '文章更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @publication_article = PublicationArticle.find(params[:id])
    @publication_article.destroy
    redirect_to [:admin, @publication_article.category.volume]
  end
  
  protected
  def find_publication_volume
    @publication_volume = PublicationVolume.find params[:publication_volume_id]
  end
end
