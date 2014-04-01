# -*- encoding : utf-8 -*-
class Admin::NewslettersController < Admin::BaseController
  
  def index
    @newsletters = Newsletter.sorted.paginate page: params[:page]
  end
  
  def show
    @newsletter = Newsletter.find(params[:id])
  end
  
  def new
    @newsletter = Newsletter.new
  end
  
  def edit
    @newsletter = Newsletter.find(params[:id])
  end
  
  def create
    @newsletter = Newsletter.new(params[:newsletter])
    if @newsletter.save
      redirect_to [:admin, @newsletter], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update_attributes(params[:newsletter])
      redirect_to [:admin, @newsletter], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy
    redirect_to admin_newsletters_path
  end
end
