# -*- encoding : utf-8 -*-
class SeminarThesesController < BaseController
  before_filter :set_location

  def show
    @seminar_thesis = SeminarThesis.find params[:id]
    @seminar = @seminar_thesis.category.seminar
    extend_location_chain @seminar_thesis.category.seminar.name, url_for(@seminar)
    extend_location_chain '论文选', seminar_thesis_categories_path(@seminar)
    extend_location_chain '论文内容'
  end
  
  protected
  def set_location
    extend_location_chain '历届研讨会', seminars_path
  end
end
