class Api::V1::ArtistsController < ApplicationController

  def index
    render :json => {:error => '505'}
  end
end
