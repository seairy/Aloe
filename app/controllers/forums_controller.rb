# -*- encoding : utf-8 -*-
class ForumsController < BaseController
  before_filter :set_location
  
  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.visible.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain @forum.name
    render 'topics/index'
  end
  
  protected
  def set_location
    extend_location_chain '交流互动', topics_path
  end
end
