class Public::ArtistsController < ApplicationController
  def index
    @artists = Artist.page(params[:page]).per(8)
    @genres = Genre.all 
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @artists = @genre.artists.page(params[:page]).per(8)
    @all_artists = Artist.where(genre_id: @genre.id)
  end
end
