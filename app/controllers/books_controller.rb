# -*- encoding : utf-8 -*-
class BooksController < BaseController
  before_filter :set_location
  
  def index
    @books = Book.available.sorted.paginate page: params[:page], per_page: 10
    extend_location_chain '全部列表'
  end
  
  def show
    @book = Book.find params[:id]
    extend_location_chain '图书信息'
  end
  
  protected
  def set_location
    extend_location_chain '图书展示', books_path
  end
end
