class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  # 以下を追加
  def create
    @books = Book.all
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
   else
      render :index
   end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end 
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path
    flash[:notice] = "Book was successfully destroyed."
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end