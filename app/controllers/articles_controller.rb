# -*- encoding : utf-8 -*-
class ArticlesController < BaseController
  before_filter :set_location
  
  def index
    @articles = Article.visible.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain '全部列表'
  end
  
  def show
    @article = Article.find params[:id]
    extend_location_chain @article.category.name, url_for(@article.category)
    extend_location_chain '文章内容'
  end
  
  protected
  def set_location
    extend_location_chain '综合信息', articles_path
  end
end
