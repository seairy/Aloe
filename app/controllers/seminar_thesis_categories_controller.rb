# -*- encoding : utf-8 -*-
class SeminarThesisCategoriesController < BaseController
  before_filter :find_seminar, :set_location
  
  def index
    @thesis_categories = @seminar.thesis_categories.sorted.all
    extend_location_chain @seminar.name, url_for(@seminar)
    extend_location_chain '论文选'
  end
  
  protected
  def find_seminar
    @seminar = Seminar.find params[:seminar_id]
  end
  
  def set_location
    extend_location_chain '历届研讨会', seminars_path
  end
end
