class BooksController < BaseController
  
  def index
    @books = Book.available.sorted.paginate page: params[:page], per_page: 10
  end
  
  def show
    @book = Book.find params[:id]
  end
end
