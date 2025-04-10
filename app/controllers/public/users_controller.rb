class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to users_mypage_path,notice:"登録情報が更新されました"
    else
      @user = current_user
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end
end
