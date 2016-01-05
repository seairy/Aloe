# -*- encoding : utf-8 -*-
class Admin::AssetsController < Admin::BaseController
  
  def index
    @statistics = { resource: Resource.all.count,
      thesis: Thesis.all.count,
      book: Book.all.count,
      seminar_photograph: SeminarPhotograph.all.count }
  end
  
  def recreate_version
    case params[:model_name]
    when 'resource' then recreate_resources_version
    when 'thesis' then recreate_theses_version
    when 'book' then recreate_books_version
    when 'seminar_photograph' then recreate_seminar_photographs_version
    end
    flash[:notice] = "重制资源版本成功！"
    redirect_to admin_assets_path
  end
  
  protected
  def recreate_resources_version
    Resource.all.each do |resource|
      
    end
  end
  
  def recreate_theses_version
    
  end
  
  def recreate_books_version
    Book.all.each do |book|
      
    end
  end
  
  def recreate_seminar_photographs_version
    
  end
end
