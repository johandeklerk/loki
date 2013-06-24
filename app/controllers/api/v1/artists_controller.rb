class Api::V1::ArtistsController < ApplicationController

  def index
    artists = Artist.all
    artists.empty? ? render(:json => nil, :status => :no_content) : render(:json => artists, :status => :ok)
  end

  def show
    artist = Artist.find(params[:id])
    render(:json => artist, :status => :ok)
  end

  def create
    Artist.create(params[:artist])
    render :json => nil, :status => :created
  end

  def update
    Artist.find(params[:id]).update(params[:artist])
    render(:json => nil, :status => :no_content)
  end

  def destroy
    artist = Artist.find(params[:id])
    artist.destroy!
    render(:json => nil, :status => :no_content)
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end