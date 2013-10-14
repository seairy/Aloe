class ThesesController < BaseController
  
  def index
    @theses = Thesis.sorted.paginate page: params[:page], per_page: 10
  end
  
  def show
    @thesis = Thesis.find params[:id]
  end
end
