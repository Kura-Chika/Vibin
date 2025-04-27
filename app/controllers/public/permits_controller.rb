class Public::PermitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.new(user: current_user, group: @group)
    if @group.permits.exists?(user_id: current_user.id, status: "rejected")
      # 既に拒否された申請が存在する場合は新たに申請可能
      @permit = @group.permits.create(user: current_user, status: "pending")
      redirect_to group_path(@group), notice: "参加申請を再度行いました。"
    else
      # 初回申請処理
      @permit = @group.permits.create(user: current_user, status: "pending")
      redirect_to group_path(@group), notice: "参加申請を行いました。"
    end
  end

  # 再申請の処理
  def reapply
    @group = Group.find(params[:group_id])
    @permit = @group.permits.find_by(user_id: current_user.id)

    # 既存の申請が拒否されている場合、statusをpendingに変更
    if @permit && @permit.status == "rejected"
      @permit.update(status: "pending")
      redirect_to group_path(@group), notice: "再申請が完了しました。"
    else
      redirect_to group_path(@group), alert: "再申請ができませんでした。"
    end
  end
  
  # ownerの申請一覧
  def update
    @permit = Permit.find(params[:id])  # Permit を直接探す
    @group = @permit.group              # permit から group を取得
  
    if @group.owner_id == current_user.id && params[:status].in?(Permit.statuses.keys)
      @permit.update(status: params[:status]) # "approved" or "rejected"
  
      # 承認ならgroupに追加
      if params[:status] == "approved"
        @group.users << @permit.user unless @group.users.include?(@permit.user)
      end
   
      redirect_to permits_list_group_path(@group), notice: "申請を#{params[:status] == 'approved' ? '承認' : '拒否'}しました。"
    else
      redirect_to permits_list_group_path(@group), alert: "申請の更新に失敗しました。"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])  # グループを取得
    # デバッグ: パラメータの確認
    Rails.logger.debug("group_id: #{@group.id}, permit_id: #{params[:id]}")
    @permit = @group.permits.find_by(id: params[:id])  # グループ内の申請を検索

    if @permit.nil?
      redirect_to group_path(@group), alert: "申請が見つかりませんでした。"
      return
    end

    if @permit.user_id == current_user.id
      @permit.destroy
      redirect_to group_path(@group), notice: "申請を取り消しました。"
    else
      redirect_to group_path(@group), alert: "権限がありません。"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
