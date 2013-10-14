# -*- encoding : utf-8 -*-
class Admin::PostersController < Admin::BaseController
  
  def index
    @posters = Poster.sorted.paginate page: params[:page]
  end
  
  def show
    @poster = Poster.find(params[:id])
  end
  
  def new
    @poster = Poster.new
  end
  
  def edit
    @poster = Poster.find(params[:id])
  end
  
  def create
    @poster = Poster.new(params[:poster])
    @poster.url = "/articles/#{params[:poster][:related_article_id]}" if params[:related_type] == '1' and not params[:poster][:related_article_id].blank?
    if @poster.save
      redirect_to [:admin, @poster], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @poster = Poster.find(params[:id])
    if @poster.update_attributes(params[:poster])
      redirect_to [:admin, @poster], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @poster = Poster.find(params[:id])
    @poster.destroy
    redirect_to admin_posters_path
  end
end
