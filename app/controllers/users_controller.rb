class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def create
  @user = User.new(user_params)
  if @user.save
    redirect_to users_path(@user), notice: "ユーザー「#{@user.name}」を登録しました。"

  else
    render 'new'
  end
end


  def show
   @user = User.find(params[:id])
   @task = Task.find_by(id: params[:id])
 end

 def destroy
  @user = User.find(params[:id])
  @user.destroy
  redirect_to users_path(@user), notice: "ユーザー「#{@user.name}」を削除しました。"
end


  private

  def user_params
    #params.require(:user).permit(:name, :email, :password,:password_confirmation)
    params.require(:user).permit(:name, :email, :password,:password_confirmation, :user_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
