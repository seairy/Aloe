# -*- encoding : utf-8 -*-
class Admin::SeminarsController < Admin::BaseController
  
  def index
    @seminars = Seminar.paginate page: params[:page]
  end
  
  def show
    @seminar = Seminar.find(params[:id])
  end
  
  def new
    @seminar = Seminar.new
  end
  
  def edit
    @seminar = Seminar.find(params[:id])
  end
  
  def create
    @seminar = Seminar.new(params[:seminar])
    if @seminar.save
      redirect_to [:admin, @seminar], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @seminar = Seminar.find(params[:id])
    if @seminar.update_attributes(params[:seminar])
      redirect_to [:admin, @seminar], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @seminar = Seminar.find(params[:id])
    @seminar.destroy
    redirect_to admin_seminars_path
  end
end
