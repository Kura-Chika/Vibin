class Public::ArtistPostsController < ApplicationController
  def create
    @artist_post = ArtistPost.new(artist_post_params)
    @artist_post.end_user_id = current_end_user.id
     # 受け取った値を,で区切って配列にする
    tag_list = params[:artist_post][:name].split(',')
    if @artist_post.save
      @artist_post.save_artist_tags(tag_list)
      redirect_to artist_posts_path, notice:'投稿が完了しました'
    else
      render :new
    end
  end
end