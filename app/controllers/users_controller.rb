class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes # prototypesの情報との紐付けはmodelで実施しているので、modelのアソシエーション名と合わせる
  end
end
