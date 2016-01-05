# -*- encoding : utf-8 -*-
class ResourcesController < BaseController
  before_filter :set_location
  
  def index
    @resources = Resource.visible.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain '全部列表'
  end
  
  def show
    @resource = Resource.find params[:id]
    extend_location_chain @resource.category.name, url_for(@resource.category)
    extend_location_chain '资源内容'
  end
  
  protected
  def set_location
    extend_location_chain '教学资源', resources_path
  end
end
