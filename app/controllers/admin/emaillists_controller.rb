# -*- encoding : utf-8 -*-
class Admin::EmaillistsController < Admin::BaseController
  
  def index
    @emaillists = Emaillist.sorted.paginate page: params[:page]
  end
  
  def show
    @emaillist = Emaillist.find(params[:id])
  end
  
  def new
    @emaillist = Emaillist.new
  end
  
  def edit
    @emaillist = Emaillist.find(params[:id])
  end
  
  def create
    @emaillist = Emaillist.new(params[:emaillist])
    if @emaillist.save
      @emaillist.recipients.bulk_create params[:recipients]
      redirect_to [:admin, @emaillist], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @emaillist = Emaillist.find(params[:id])
    if @emaillist.update_attributes(params[:emaillist])
      redirect_to [:admin, @emaillist], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @emaillist = Emaillist.find(params[:id])
    @emaillist.destroy
    redirect_to admin_emaillists_path
  end
end
