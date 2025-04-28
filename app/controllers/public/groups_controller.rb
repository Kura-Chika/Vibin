class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:new, :create]

  def index 
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @permit = @group.permits.find_by(user_id: current_user.id) # 現在のユーザーの申請を取得
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.owned_groups.new(group_params)
    @group.users << current_user # 自動で作成者をグループのメンバーに追加
    if @group.save
      redirect_to @group, notice: 'グループを作成しました'
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def permits_list
    @group = Group.find_by(id: params[:id])
    unless @group
      redirect_to root_path, alert: "グループが存在しません。"
      return
    end

    if @group.owner_id != current_user.id
      redirect_to root_path, alert: "権限がありません。"
      return
    end
    @permits = @group.permits.includes(:user) # 申請中だけ
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, artist_ids: [])
  end

  # owner_idがログインuser_idと同じか確認。
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path(@group), alert: "グループオーナーのみ編集できます。"
    end
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to groups_path, alert: "ゲストユーザーはこの操作を行えません。"
    end
  end

end
