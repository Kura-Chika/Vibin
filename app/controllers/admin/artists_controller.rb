class Admin::ArtistsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @artist = Artist.new
    @artists = Artist.all
    @btn_text = '新規登録'
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = "アーティストを追加しました"
      redirect_to admin_artists_path
    else
      @artists = Artist.all
      render :index
    end
  end

  def edit
    @artist = Artist.find(params[:id])
    @btn_text = '変更を保存'
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
    params.require(:artist).permit(:name, :introduction, :artist_image, :genre_id)
  end
end
