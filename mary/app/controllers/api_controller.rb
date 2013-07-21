class ApiController < ApplicationController
  def routing_error
    render :json => {:error => 'URL must be in the format /RESOURCES and contain the correct Accept header'}, :status => :bad_request
  end
end