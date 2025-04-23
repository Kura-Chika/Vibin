class Public::ArtistGroupsController < ApplicationController
  def create
    @artist_group = ArtistGroup.new(artist_group_params)
    @artist_group.end_user_id = current_end_user.id
     # 受け取った値を,で区切って配列にする
    tag_list = params[:artist_group][:name].split(',')
    if @artist_group.save
      @artist_group.save_artist_tags(tag_list)
      redirect_to artist_groups_path, notice:'投稿が完了しました'
    else
      render :new
    end
  end
end