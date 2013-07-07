class Api::V1::PublishersController < ApplicationController

  private
  def publisher_params
    params.require(:publisher).permit(:name)
  end
end
