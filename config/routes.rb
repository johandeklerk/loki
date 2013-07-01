Loki::Application.routes.draw do

  api vendor_string: 'loki', default_version: 1, path: '/' do
    version 1 do
      cache as: 'v1' do
        root 'api#index'

        concern :has_genres do |options|
          resources :genres, options.merge(:only => [:index, :show])
        end

        concern :has_albums do |options|
          resources :albums, options.merge(:only => [:index, :show], :concerns => :has_genres)
        end

        resources :artists, :concerns => :has_albums

        resources :albums, :concerns => :has_genres do
          resource :artist, :only => [:show], :concerns => :has_genres
        end

        resources :genres do
          resources :albums, :only => [:index, :show]
          resources :artists, :only => [:index, :show]
        end
      end
    end
  end

  match '*url', via: [:get, :post, :put, :delete], :to => 'api#routing_error'
end