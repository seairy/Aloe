# -*- encoding : utf-8 -*-
class Admin::SessionsController < Admin::BaseController
  skip_before_filter :authenticate
  layout :null => true

  def create
  	administrator = Administrator.where(:account => params[:account]).first.try(:authenticate, params[:password])
    unless administrator.blank?
      if administrator.available?
        administrator.update_attribute :last_signined_at, administrator.current_signined_at
        administrator.update_attribute :current_signined_at, Time.now
        session[:administrator] = { id: administrator.id, role_id: administrator.role_id, name: administrator.name, last_signined_at: administrator.last_signined_at }
        redirect_to admin_root_path
      else
        redirect_to admin_signin_path(account_unavailable: 1)
      end
    else
      redirect_to admin_signin_path(invalid_password: 1)
    end
  end

  def destroy
    reset_session
    redirect_to admin_signin_path
  end
end
