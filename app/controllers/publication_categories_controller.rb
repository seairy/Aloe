# -*- encoding : utf-8 -*-
class PublicationCategoriesController < BaseController
  before_filter :set_location
  
  def index
    @publication_categories = PublicationCategory.for_volume params[:volume]
    extend_location_chain "第#{params[:volume]}期"
  end
  
  def show
    @seminar = Seminar.find params[:id]
    extend_location_chain @seminar.name
  end
  
  protected
  def set_location
    extend_location_chain '《世界汉语教学》', seminars_path
  end
end
