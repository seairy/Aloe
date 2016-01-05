# -*- encoding : utf-8 -*-
class Admin::ErrorsController < Admin::BaseController
  
  def index
    @errors = Error.sorted.paginate page: params[:page]
  end
  
  def show
    @error = Error.find(params[:id])
  end
  
  def destroy
    @error = Error.find(params[:id])
    @error.destroy
    redirect_to admin_errors_path
  end
  
  def raise_an_exception
    inexistent_method!
  end
end
