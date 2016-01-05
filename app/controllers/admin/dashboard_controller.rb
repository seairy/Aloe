# -*- encoding : utf-8 -*-
class Admin::DashboardController < Admin::BaseController

  def index
    @all_members_count = Member.approved.count
    @domestic_individual_members_count = IndividualMember.approved.domestic.count
    @foreign_individual_members_count = IndividualMember.approved.foreign.count
    @domestic_organization_members_count = OrganizationMember.approved.domestic.count
    @foreign_organization_members_count = OrganizationMember.approved.foreign.count
  end
end
