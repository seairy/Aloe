# -*- encoding : utf-8 -*-
class OrganizationMembersController < BaseController
  before_filter :set_location
  
  def index
    @organization_members = Member.approved.all
  end

  def show
    @member = Member.find params[:id]
    extend_location_chain @member.country.continent.name, url_for(@member.country.continent)
    extend_location_chain @member.country.name, url_for(@member.country)
    extend_location_chain '会员列表'
  end
  
  protected
  def set_location
    extend_location_chain '通讯录', continents_path
  end
end
