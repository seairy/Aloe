# -*- encoding : utf-8 -*-
class ResourceCategoriesController < BaseController
  before_filter :set_location
  
  def show
    @resource_category = ResourceCategory.find(params[:id])
    @resources = @resource_category.resources.visible.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain @resource_category.name
    render 'resources/index'
  end
  
  protected
  def set_location
    extend_location_chain '教学资源', resources_path
  end
end
