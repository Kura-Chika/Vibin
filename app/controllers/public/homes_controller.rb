class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:user).order(created_at: :desc).limit(4)
    @groups = Group.order(created_at: :desc).limit(4)
  end

  def about
  end
end
