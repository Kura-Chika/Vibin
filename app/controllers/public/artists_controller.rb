class Public::ArtistsController < ApplicationController
  def index
    @artists = Artist.includes(:genre).page(params[:page]).per(8)
  end

  def show
    @artist = Artist.find(params[:id])
    @posts = @artist.posts
    @groups = @artist.groups
  end
end
