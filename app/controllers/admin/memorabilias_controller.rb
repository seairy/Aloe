# -*- encoding : utf-8 -*-
class Admin::MemorabiliasController < Admin::BaseController
  
  def index
    @memorabilias = Memorabilia.sorted.paginate page: params[:page]
  end
  
  def show
    @memorabilia = Memorabilia.find(params[:id])
  end
  
  def new
    @memorabilia = Memorabilia.new
  end
  
  def edit
    @memorabilia = Memorabilia.find(params[:id])
  end
  
  def create
    @memorabilia = Memorabilia.new(params[:memorabilia])
    if @memorabilia.save
      redirect_to [:admin, @memorabilia], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @memorabilia = Memorabilia.find(params[:id])
    if @memorabilia.update_attributes(params[:memorabilia])
      redirect_to [:admin, @memorabilia], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @memorabilia = Memorabilia.find(params[:id])
    @memorabilia.destroy
    redirect_to admin_memorabilias_path
  end
end
