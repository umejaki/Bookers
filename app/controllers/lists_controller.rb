class ListsController < ApplicationController
  def new
    @list = List.new
  end

  # 以下を追加
  def create
    @lists = List.all
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @list = List.new(list_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @list.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to list_path(@list.id)
   else
      render :new
   end
  end

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
    redirect_to list_path(@list.id)
    else
      render :edit
    end
  end 
  
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
     flash[:notice] = "Book was successfully destroyed."
  end
  
  private
  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body)
  end
  end