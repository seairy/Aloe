# -*- encoding : utf-8 -*-
class Admin::BaseController < ApplicationController
  OMNIPOTENT_CONTROLLERS = %w{roles administrators tests data errors assets}
  ERROR_ACTIONS = %w{error_403 error_404 error_500}
  before_filter :authenticate
  before_filter :find_notifications
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end
  
  def search
    if params[:keywords].blank?
      render '/shared/admin/search'
    else
      results = controller_name.classify.constantize.search do
        fulltext params[:keywords]
        paginate page: params[:page] || 1
      end.results
      instance_variable_set("@#{controller_name}", results)
      render 'index'
    end
  end

  protected
  def render_error status, exception
    Error.create(administrator_id: session[:administrator][:id], name: exception.class.to_s, message: exception.message, backtrace: "<p>#{exception.backtrace.join('</p><p>')}</p>")
    render template: "admin/errors/error_#{status}", layout: 'layouts/admin/base', status: status
  end
  
  def authenticate
    if session[:administrator].blank?
      redirect_to admin_signin_path
    else
      role = Role.find(session[:administrator][:role_id])
      permission = role.permissions.where(controller_name: controller_name, action_name: action_name).first
      if OMNIPOTENT_CONTROLLERS.include? controller_name and not ERROR_ACTIONS.include? action_name and not role.omnipotent?
        redirect_to admin_error_403_path
      elsif not permission.blank? and not permission.allowed?
        redirect_to admin_error_403_path
      else
        permission_denied = permission.blank? or (not permission.blank? and not permission.allowed?)
        if action_name == 'new' or action_name == 'create'
          redirect_to admin_error_403_path if not role.creatable? and permission_denied
        elsif action_name == 'edit' or action_name == 'update'
          redirect_to admin_error_403_path if not role.updatable? and permission_denied
        elsif action_name == 'index'
          redirect_to admin_error_403_path if not role.listable? and permission_denied
        elsif action_name == 'show'
          redirect_to admin_error_403_path if not role.showable? and permission_denied
        elsif action_name == 'destroy'
          redirect_to admin_error_403_path if not role.destroyable? and permission_denied
        elsif action_name == 'search'
          redirect_to admin_error_403_path if not role.searchable? and permission_denied
        elsif controller_name != 'errors'
          redirect_to admin_error_403_path if not role.operatable?
        end
      end
    end
  end
  
  def find_notifications
    @unread_notifications_count = Notification.for_administrator(session[:administrator][:id]).unread.count
    @unread_notifications_count = '99+' if @unread_notifications_count > 99
    @dropdown_notifications = Notification.for_administrator(session[:administrator][:id]).unread.sorted.limit(5)
  end
end
