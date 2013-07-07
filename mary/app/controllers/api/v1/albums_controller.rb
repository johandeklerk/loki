class Api::V1::AlbumsController < ApplicationController

  private
  def album_params
    params.require(:album).permit(:title, :isbn, :publisher, :published_date, :artists, :tracks, :genres)
    params.permit(:query)
  end
end
