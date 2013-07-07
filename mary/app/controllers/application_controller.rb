class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  rescue_from Exception, :with => :default_error
  rescue_from ActionController::RoutingError, :with => :routing_error

  # Abstract controller methods to DRY up the concrete controllers
  before_filter :set_model

  def index
    models = @model.all
    models.empty? ? render_json(nil, :no_content) : render_json(models, :ok)
  end

  def show
    model = @model.find(params[:id])
    return render_json(model, :ok) if model
    render_json({}, :not_found) unless model
  end

  def create
    model = @model.create(params[@params_model])
    return render_json({:id => model.id.to_s}, :created) if model.valid?
    render_json({:errors => model.errors}, :internal_server_error) unless model.valid?
  end

  def update
    model = @model.find(params[:id])
    return render_json({}, :not_found) unless model
    model.write_attributes(params[@params_model])
    model.save
    render_json(:id => model.id.to_s)
  end

  def destroy
    model = @model.find(params[:id])
    return render_json({}, :not_found) unless model
    model.remove
    render_json(:id => model.id.to_s)
  end

  # TODO: This search method is potentially very unsafe. It takes any JSON string and gives it to Mongo without any checks. But... its kinda cool :)
  def search
    return render_json({:error => 'Specify the query in the HTTP QUERY header'}, :internal_server_error) unless request.headers.key?('HTTP_QUERY')
    albums = Album.collection.find(JSON.parse(request.headers['HTTP_QUERY']))
    render_json(albums, :ok)
  end

  private

  # Finds the model associated with current controller
  def set_model
    model_name = self.class.to_s.split('::').last.gsub('Controller', '').singularize
    @params_model = model_name.downcase.to_sym
    @model = model_name.constantize
  end

  def render_json(json = {}, status = :ok)
    render :json => json, :status => status
  end

  # Log exception class, message and backtrace for debugging
  def log_exception(exception)
    logger.error exception.class.name
    logger.error exception.message
    logger.error exception.backtrace
  end

  # Logs exceptions and render a default JSON error message
  def default_error(exception)
    log_exception(exception)
    render :json => {:error => 'Server error'}, :status => :internal_server_error
  end

  # Logs attribute errors and renders a default JSON error message
  def attribute_error(exception)
    log_exception(exception)
    render :json => {:error => development? ? exception.message : 'Attribute error'}, :status => :not_implemented
  end

  # Renders a empty JSON array with a 404
  def record_not_found
    render :json => [], :status => :not_found
  end

  # Renders a standard routing error in JSON
  def routing_error
    ApiController.new.routing_error
  end
end