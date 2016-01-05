# -*- encoding : utf-8 -*-
class Admin::ExcelsController < Admin::BaseController
  respond_to :xls
  
  def all_members
    @individual_members = IndividualMember.approved.all
    @organization_members = OrganizationMember.approved.all
  end
end

