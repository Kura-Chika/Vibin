class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_user = GroupUser.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy # 参加希望者リストから削除
    redirect_to request.referer
  end
  
  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    if group_user
      group_user.destroy
      redirect_to group_path(params[:group_id]), notice: "グループを抜けました。"
    else
      redirect_to group_path(params[:group_id]), alert: "このグループに参加していないため、グループを抜けることができません。"
    end
  end
end
