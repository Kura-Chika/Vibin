class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group, only: [:destroy]

  def index
    @groups = Group.all
  end

  def destroy
    @group.destroy
    flash[:notice] = "グループを削除しました"
    redirect_to admin_groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
