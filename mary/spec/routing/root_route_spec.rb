require 'spec_helper'

describe 'Routing to root' do
  it 'routes invalid URLs to api#routing_error' do
    expect(:get => '/').to route_to(:controller => 'api', :action => 'routing_error')
    expect(:get => '/somethingrandom').to route_to(:controller => 'api', :action => 'routing_error', :url => 'somethingrandom')
    expect(:get => '/1/somethingrandom').to route_to(:controller => 'api', :action => 'routing_error', :url => '1/somethingrandom')
    expect(:get => '/v1/somethingrandom').to route_to(:controller => 'api', :action => 'routing_error', :url => 'v1/somethingrandom')
    expect(:get => '/api/v1/somethingrandom').to route_to(:controller => 'api', :action => 'routing_error', :url => 'api/v1/somethingrandom')
    expect(:get => '/v1/api/somethingrandom').to route_to(:controller => 'api', :action => 'routing_error', :url => 'v1/api/somethingrandom')
  end
end