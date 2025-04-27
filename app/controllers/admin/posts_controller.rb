class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = Post.page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to admin_posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
