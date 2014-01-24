# -*- encoding : utf-8 -*-
class Admin::MembersController < Admin::BaseController
  
  def index
    @members = Member.sorted.paginate page: params[:page]
  end
  
  def duplicated
    @members = Member.duplicated.all
  end

  def generate_password
    generated_password = Random.new.rand(123456..987654).to_s
    @member = Member.find(params[:id])
    @member.update_attribute :hashed_password, Digest::MD5.hexdigest(generated_password)
    redirect_path = @member.individual? ? admin_individual_member_path(@member, generated_password: generated_password) : admin_organization_member_path(@member, generated_password: generated_password)
    redirect_to redirect_path, notice: "密码重置成功！"
  end
end
