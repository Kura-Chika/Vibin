class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def edit
    @user = current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def mypage
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice:"プロフィールが更新されました"
    else
      render :edit
    end
  end

  def posts
    @user_posts = current_user.posts
  end
  
  def goods
    @user_goods = Post.user_goods(current_user, params[:page], 12)
  end
  
  def groups
    @user_groups = current_user.groups
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
    params.require(:user).permit(:nickname, :email, :introduction, :user_image)
  end

  def ensure_correct_user
    @user = current_user
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
end
