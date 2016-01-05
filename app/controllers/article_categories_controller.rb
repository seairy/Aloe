# -*- encoding : utf-8 -*-
class ArticleCategoriesController < BaseController
  before_filter :set_location
  
  def show
    @article_category = ArticleCategory.find(params[:id])
    @articles = @article_category.articles.visible.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain @article_category.name
    render 'articles/index'
  end
  
  protected
  def set_location
    extend_location_chain '综合信息', articles_path
  end
end
