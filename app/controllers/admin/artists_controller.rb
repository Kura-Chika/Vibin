class Admin::ArtistsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @artist = Artist.new
    @artists = Artist.all
  end

  def create
    @Artist = Artist.new(genre_params)
    if @Artist.save
      flash[:notice] = "アーティストを追加しました"
      redirect_to admin_artists_path
    else
      @artists = Artist.all
      render :index
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      flash[:notice] = "アーティストを変更しました"
      redirect_to admin_artists_path
    else
      render :edit
    end
  end


  private

  def artist_params
    params.require(:artist).permit(:name, :introduction)
  end
end
