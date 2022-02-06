class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update] #move_to_indexと同じ処理を表すため、こっちにまとめる
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, only: [:edit]

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
    @comment = Comment.new #コントローラーからデータをビューに渡したいときはインスタンス変数を使う（@XXX）
    @comments = @prototype.comments.includes(:user) #prototypeに紐付いたコメントを取得
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params) 
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id) #permitメソッドを使用して、カラムに保存したいデータを選択
  end

  def set_prototype #下部のmove_to_indexで@prototypeを使うので、private内に@prototypeを定義する必要あり
    # @prototypeを定義することで以下の記述が上記にもあれば、before_actionを記述することでまとめられる
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end
  end
end
