class TokensController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  attr_accessor :user

  before_filter :http_basic_authenticate

  def show
    render :json => {token: @user.token}
  end

  private

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @user = User.where(:username => username, :password => Digest::MD5.hexdigest(password)).first
      @user.nil? ? false : @user.generate_token
    end
  end
end
