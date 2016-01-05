# -*- encoding : utf-8 -*-
class NewslettersController < BaseController
  before_filter :set_location
  
  def index
    @newsletters = Newsletter.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain '全部列表'
  end
  
  protected
  def set_location
    extend_location_chain '世界汉语教学学会通讯', newsletters_path
  end
end
