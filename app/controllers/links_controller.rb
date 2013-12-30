# -*- encoding : utf-8 -*-
class LinksController < BaseController
  before_filter :set_location
  
  def index
    @links = Link.sorted.all
    extend_location_chain '全部列表'
  end
  
  protected
  def set_location
    extend_location_chain '友情链接', links_path
  end
end
