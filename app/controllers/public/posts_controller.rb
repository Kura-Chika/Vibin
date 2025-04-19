class Public::PostsController < ApplicationController
  #before_action :ensure_correct_user, only: [:edit, :update]
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @user = current_user
    @artist_posts = ArtistPost.all
    @tag_list = Artist.all
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @artist_post = ArtistPost.new(artist_post_params)
    @artist_post.end_user_id = current_end_user.id
     # 受け取った値を,で区切って配列にする
    tag_list = params[:artist_post][:name].split(',')
    if @artist_post.save
      @artist_post.save_workout_tags(tag_list)
      redirect_to artist_posts_path, notice:'投稿が完了しました'
    else
      render :new
    end
  
    if @post.save
      flash[:notice] = "新規投稿に成功しました"
      redirect_to post_path(@post)
    else
      @user = current_user
      @posts = Post.all
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    @artist_post = ArtistPost.find(params[:id])
    @tag_list = @artist_post.workout_tags.pluck(:name).join(',')
    @artist_post_tags = @artist_post.workout_tags
  end

  def edit
    @post = Post.find(params[:id])
    @artist_post = ArtistPost.find(params[:id])
    @tag_list = @artist_post.artist_tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の更新に成功しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end

    @artist_post = ArtistPost.find(params[:id])
    tag_list=params[:artist_post][:name].split(',')
    if @artist_post.update(artist_post_params)
      @artist_post.save_artist_tags(tag_list)
      redirect_to post_artists_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end

end
