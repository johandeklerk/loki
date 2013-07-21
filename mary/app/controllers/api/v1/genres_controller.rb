class Api::V1::GenresController < ApplicationController

  private
  def genre_params
    params.require(:genre).permit(:name)
    params.permit(:query)
  end
end
