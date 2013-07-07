class ApiController < ApplicationController
  def routing_error
    render :json => {:error => 'URL must be in the format /VERSION/RESOURCE'}, :status => :bad_request
  end
end