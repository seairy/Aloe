# -*- encoding : utf-8 -*-
class CountriesController < BaseController
  before_filter :set_location
  
  def show
    @country = Country.find params[:id]
    @members = Member.where(country_id: @country.id).paginate page: params[:page], per_page: 20
    extend_location_chain @country.continent.name, url_for(@country.continent)
    extend_location_chain @country.name, url_for(@country)
    extend_location_chain '会员列表'
  end
  
  protected
  def set_location
    extend_location_chain '通讯录', continents_path
  end
end
