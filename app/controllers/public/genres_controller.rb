class Public::GenresController < ApplicationController
  def index
    @genres = Genre.all.page(params[:page]).per(12)
  end

  def show
    @genre = Genre.find(params[:id])
    @artists = @genre.artists.includes(:posts, :groups).page(params[:page]).per(8)
  end
end
