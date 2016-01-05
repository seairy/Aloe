# -*- encoding : utf-8 -*-
class Admin::ThesesController < Admin::BaseController
  
  def index
    @theses = Thesis.sorted.paginate page: params[:page]
  end
  
  def show
    @thesis = Thesis.find(params[:id])
  end
  
  def new
    @thesis = Thesis.new
  end
  
  def edit
    @thesis = Thesis.find(params[:id])
  end
  
  def create
    @thesis = Thesis.new(params[:thesis])
    if @thesis.save
      redirect_to [:admin, @thesis], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @thesis = Thesis.find(params[:id])
    if @thesis.update_attributes(params[:thesis])
      redirect_to [:admin, @thesis], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @thesis = Thesis.find(params[:id])
    @thesis.destroy
    redirect_to admin_theses_path
  end
end
