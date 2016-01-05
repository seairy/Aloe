# -*- encoding : utf-8 -*-
class Admin::TestsController < Admin::BaseController
  
  def index
    
  end
  
  def send_notifications
    params[:count].to_i.downto(1).each do
      Notification.create(administrator_id: session[:administrator][:id], title: (0...10).map{ ('a'..'z').to_a[rand(26)] }.join, content: (0...500).map{ ('a'..'z').to_a[rand(26)] }.join)
    end
    flash[:notice] = "发送通知成功！"
    redirect_to admin_tests_path
  end
end
