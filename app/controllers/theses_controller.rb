# -*- encoding : utf-8 -*-
class ThesesController < BaseController
  before_filter :set_location
  
  def index
    if params[:year].blank?
      @theses = Thesis.sorted.paginate page: params[:page], per_page: 10
      extend_location_chain '全部列表'
    else
      @theses = Thesis.year_for(params[:year]).sorted.paginate page: params[:page], per_page: 10
      extend_location_chain "#{params[:year]}年"
    end
  end
  
  def show
    @thesis = Thesis.find params[:id]
    extend_location_chain "#{@thesis.published_at.strftime('%Y')}年", theses_path(year: @thesis.published_at.strftime('%Y'))
    extend_location_chain '文章内容'
  end
  
  protected
  def set_location
    extend_location_chain '世汉论坛', theses_path
  end
end
