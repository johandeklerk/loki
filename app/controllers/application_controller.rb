class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  rescue_from Exception, :with => :default_error
  rescue_from ActiveRecord::UnknownAttributeError, :with => :attribute_error
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def default_error(exception)
    logger.error exception.class.name
    logger.error exception.message
    logger.error exception.backtrace
    render :json => {:error => 'Server error'}, :status => :internal_server_error
  end

  def attribute_error(exception)
    render :json => {:error => exception.message}, :status => :not_implemented
  end

  def record_not_found
    render :json => [], :status => :not_found
  end
end
