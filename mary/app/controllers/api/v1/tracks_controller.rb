class Api::V1::TracksController < ApplicationController

  private
  def track_params
    params.require(:track).permit(:name, :length)
    params.permit(:query)
  end
end
