class TopicsController < BaseController
  
  def index
    @topics = Topic.visible.sorted.paginate page: params[:page], per_page: 10
  end
  
  def show
    @topic = Topic.find params[:id]
  end
end
