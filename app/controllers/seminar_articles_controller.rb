# -*- encoding : utf-8 -*-
class SeminarArticlesController < BaseController
  before_filter :find_seminar, :set_location
  
  def index
    @seminar_articles = @seminar.articles.visible.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain @seminar.name, url_for(@seminar)
    extend_location_chain '会议报道'
  end
  
  def show
    @seminar_article = SeminarArticle.find params[:id]
    extend_location_chain @seminar.name, url_for(@seminar)
    extend_location_chain '会议报道', seminar_articles_path(@seminar)
    extend_location_chain '文章内容'
  end
  
  protected
  def find_seminar
    @seminar = Seminar.find params[:seminar_id]
  end
  
  def set_location
    extend_location_chain '历届研讨会', seminars_path
  end
end
