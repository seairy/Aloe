# -*- encoding : utf-8 -*-
class SeminarsController < BaseController
  before_filter :set_location
  
  def index
    @seminars = Seminar.sorted
    extend_location_chain '全部列表'
  end
  
  def show
    @seminar = Seminar.find params[:id]
    extend_location_chain @seminar.name
  end
  
  protected
  def set_location
    extend_location_chain '历届研讨会', seminars_path
  end
end
