class Api::V1::TracksController < ApplicationController

  private
  def track_params
    params.require(:track).permit(:name, :length)
  end
end
