class ResourcesController < BaseController
  
  def index
    @resources = Resource.visible.sorted.paginate page: params[:page], per_page: 10
  end
  
  def show
    @resource = Resource.find params[:id]
  end
end
