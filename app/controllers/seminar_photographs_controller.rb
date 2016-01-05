# -*- encoding : utf-8 -*-
class SeminarPhotographsController < BaseController
  before_filter :find_seminar, :set_location
  
  def index
    @seminar_photographs = @seminar.photographs.paginate page: params[:page], per_page: 12
    extend_location_chain @seminar.name, url_for(@seminar)
    extend_location_chain '会议相册'
  end
  
  protected
  def find_seminar
    @seminar = Seminar.find params[:seminar_id]
  end
  
  def set_location
    extend_location_chain '历届研讨会', seminars_path
  end
end
