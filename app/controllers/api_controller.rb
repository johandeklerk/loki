class ApiController < ApplicationController

  def routing_error
    render :json => nil, :status => :bad_request
  end
end