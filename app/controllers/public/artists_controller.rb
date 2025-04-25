class Public::ArtistsController < ApplicationController
  def index
    @artists = Artist.includes(:genre).page(params[:page]).per(8)
  end

  def show
    @artist = Artist.find(params[:id])
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @artists = @genre.artists.page(params[:page]).per(8)
    @all_artists = Artist.where(genre_id: @genre.id)
    @posts = @artist.posts
    @groups = @artist.groups
  end
end
