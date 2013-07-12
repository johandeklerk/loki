class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    puts @artists[1].albums.inspect
    render :json => @artists
  end
end
