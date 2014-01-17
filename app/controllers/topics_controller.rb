# -*- encoding : utf-8 -*-
class TopicsController < BaseController
  before_filter :set_location
  
  def index
    @topics = Topic.visible.latest.paginate page: params[:page], per_page: 10
    extend_location_chain '全部列表'
  end
  
  def show
    @topic = Topic.find params[:id]
    extend_location_chain @topic.forum.name, url_for(@topic.forum)
    extend_location_chain '文章内容'
  end
  
  protected
  def set_location
    extend_location_chain '交流互动', topics_path
  end
end
