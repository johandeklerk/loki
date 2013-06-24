class Api::V1::ApiController < ApplicationController

  def index
    render :json => {:error => 'URL must be in the format VERSION/(RESOURCE)'}, :status => 400
  end
end
