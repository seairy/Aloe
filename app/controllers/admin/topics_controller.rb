# -*- encoding : utf-8 -*-
class Admin::TopicsController < Admin::BaseController
  
  def index
    @topics = Topic.sorted.paginate page: params[:page]
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def new
    @topic = Topic.new
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect_to [:admin, @topic], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to [:admin, @topic], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to admin_topics_path
  end
end
