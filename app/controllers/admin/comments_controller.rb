class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_comment, only: [:destroy]
  
  def index
    @comments = Comment.includes(:post, :user).order(created_at: :desc)
  end

  def destroy
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_post_path(@post)
  end

  private

  def set_comment
    @comment = @post.comments.find(params[:id])
  end
  
end
