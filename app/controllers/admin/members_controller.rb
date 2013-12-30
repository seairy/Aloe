# -*- encoding : utf-8 -*-
class Admin::MembersController < Admin::BaseController
  
  def index
    @members = Member.sorted.paginate page: params[:page]
  end
  
  def duplicated
    @members = Member.duplicated
  end
end
