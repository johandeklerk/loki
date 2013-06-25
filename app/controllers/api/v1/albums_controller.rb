class Api::V1::AlbumsController < ApplicationController

  def index
    albums = Album.all
    albums.empty? ? render(:json => nil, :status => :no_content) : render(:json => albums, :status => :ok)
  end

  def show
    album = Album.find(params[:id])
    render(:json => album, :status => :ok)
  end

  def create
    Album.create(params[:artist])
    render :json => nil, :status => :created
  end

  def update
    Album.find(params[:id]).update(params[:artist])
    render(:json => nil, :status => :no_content)
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy!
    render(:json => nil, :status => :no_content)
  end

  private

  def album_params
    params.require(:album).permit(:title, :release_date, :isbn, :artist_id)
  end
end
