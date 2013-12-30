# -*- encoding : utf-8 -*-
class PublicationsController < BaseController
  before_filter :set_location
  
  def index
    @publications = PublicationCategory.volumes
    extend_location_chain '期刊列表'
  end
  
  protected
  def set_location
    extend_location_chain '《世界汉语教学》', seminars_path
  end
end
