# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :init_location_chain
  
  protected
  def init_location_chain
    @location_chain = []
  end
  
  def extend_location_chain name, url = nil
    @location_chain << { name: name, url: url}
  end
end
