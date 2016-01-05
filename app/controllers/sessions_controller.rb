# -*- encoding : utf-8 -*-
class SessionsController < BaseController
  before_filter :set_location
  
  def create
    member = Member.signin(params[:account], params[:password]).first
    unless member.blank?
      member.update_attribute :last_signined_at, member.current_signined_at
      member.update_attribute :current_signined_at, Time.now
      session[:member] = { id: member.id, type: member.type, account: member.account, chinese_name: member.chinese_name, expired_at: member.expired_at, last_signined_at: member.last_signined_at }
      redirect_to root_path
    else
      redirect_to signin_path, alert: '账号不存在或密码错误，请重试'
    end
  end

  def destroy
    session[:member] = nil
    redirect_to root_path
  end
  
  protected
  def set_location
    extend_location_chain '会员登录'
  end
end
