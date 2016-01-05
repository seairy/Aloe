# -*- encoding : utf-8 -*-
class BaseController < ApplicationController
  
  protected
  def authenticate
    redirect_to signin_path unless session[:member]
  end
end
