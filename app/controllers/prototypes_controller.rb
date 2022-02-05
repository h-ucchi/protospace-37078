class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :destroy]
  before_action :move_to_index, except: [:index]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new  #newアクションにインスタンス変数@prototypeを定義し、Prototypeモデルの新規オブジェクトを代入
  end

  def create
    # createはnew+saveであり、以下のnewメソッドとsaveメソッドと重複するから不要
    @prototype = Prototype.new(prototype_params)
    if @prototype.save #保存するメソッド->.saveが必要
      redirect_to root_path
    else
      render :new # 同一ファイル内で定義した作業を指定できる（:defで指定した作業、これだったらnewメソッドということ）
    end
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user) #prototypeに紐付いたコメントを取得
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params) 
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id) #permitメソッドを使用して、カラムに保存したいデータを選択
  end

  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
