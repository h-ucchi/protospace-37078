class CommentsController < ApplicationController
  def create
    # createはnew+saveであり、以下のnewメソッドとsaveメソッドと重複するから不要
    @prototype = Prototype.find(params[:prototype_id])#commentに紐づくprototypeを呼び出すように記述する
    @comment = Comment.new(comment_params)
    if @comment.save #保存するメソッド->.saveが必要
      redirect_to prototype_path(@prototype.id)
    else
      @comments = @prototype.comments.includes(:user) # ：が付いてたらカラム名を表す
      render "prototypes/show" #prototypeのshowに戻る必要があるので、階層を定義する
    end
  end
end

private
  
def comment_params
  params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id]) #permitメソッドを使用して、カラムに保存したいデータを選択
  # prototype_idカラムは、paramsで渡されるようにするので、params[:prototype_id]として保存しています
end
