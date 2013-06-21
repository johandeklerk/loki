class ApiController < ApplicationController

  def index
    render :json => {:error => "URL must be in the format VERSION/RESOURCE"}
  end
end
