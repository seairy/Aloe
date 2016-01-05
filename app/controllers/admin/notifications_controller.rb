# -*- encoding : utf-8 -*-
class Admin::NotificationsController < Admin::BaseController
  before_filter :find_administrator
  
  def index
    @notifications = @administrator.notifications.sorted.paginate page: params[:page]
  end
  
  def show
    @notification = @administrator.notifications.find(params[:id])
    @notification.read!
  end
  
  def destroy
    @notification = @administrator.notifications.find(params[:id])
    @notification.destroy
    redirect_to admin_notifications_path
  end
  
  protected
  def find_administrator
    @administrator = Administrator.find session[:administrator][:id]
  end
end
