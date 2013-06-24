class Api::V1::ApiController < ApplicationController

  def index
    render :json => {:error => 'URL must be in the format /RESOURCE(S)'}, :status => 400
  end
end