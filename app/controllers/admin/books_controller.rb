# -*- encoding : utf-8 -*-
class Admin::BooksController < Admin::BaseController
  
  def index
    @books = Book.paginate page: params[:page]
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def new
    @book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to [:admin, @book], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      redirect_to [:admin, @book], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end
end
