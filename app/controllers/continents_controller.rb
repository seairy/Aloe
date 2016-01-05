# -*- encoding : utf-8 -*-
class ContinentsController < BaseController
  before_filter :set_location
  
  def index
    @africa = Continent.where(name: '非洲').first
    @asia = Continent.where(name: '亚洲').first
    @australia_and_southern_pacific = Continent.where(name: '大洋洲').first
    @europe = Continent.where(name: '欧洲').first
    @north_america = Continent.where(name: '北美洲').first
    @south_america = Continent.where(name: '南美洲').first
    extend_location_chain '选择洲'
  end
  
  def show
    @continent = Continent.find params[:id]
    extend_location_chain @continent.name, url_for(@continent)
    extend_location_chain '选择国家'
  end
  
  protected
  def set_location
    extend_location_chain '通讯录', continents_path
  end
end
