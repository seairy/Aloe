# -*- encoding : utf-8 -*-
class Admin::ArticlesController < Admin::BaseController
  
  def index
    @articles = Article.sorted.paginate page: params[:page]
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to [:admin, @article], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to [:admin, @article], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end
end
