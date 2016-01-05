# -*- encoding : utf-8 -*-
class OrganizationMembersController < BaseController
  
  def index
    @organization_members = OrganizationMember.approved.all
    extend_location_chain '单位会员'
  end

  def show
    @member = Member.find params[:id]
    extend_location_chain '通讯录', continents_path
    extend_location_chain @member.country.continent.name, url_for(@member.country.continent)
    extend_location_chain @member.country.name, url_for(@member.country)
    extend_location_chain '会员列表'
  end
end
