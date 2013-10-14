class Admin::BaseController < ApplicationController
  before_filter :authenticate

  protected
  def authenticate
    if session[:administrator].blank?
      redirect_to admin_signin_path
    else
      
    end
  end
end