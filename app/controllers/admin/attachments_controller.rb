# -*- encoding : utf-8 -*-
class Admin::AttachmentsController < Admin::BaseController
  
  def index
    @attachments = Attachment.sorted.paginate page: params[:page]
  end
  
  def show
    @attachment = Attachment.find(params[:id])
  end
  
  def new
    @attachment = Attachment.new
  end
  
  def edit
    @attachment = Attachment.find(params[:id])
  end
  
  def create
    @attachment = Attachment.new(params[:attachment])
    if @attachment.save
      redirect_to [:admin, @attachment], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @attachment = Attachment.find(params[:id])
    if @attachment.update_attributes(params[:attachment])
      redirect_to [:admin, @attachment], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    redirect_to admin_attachments_path
  end
end
