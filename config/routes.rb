Loki::Application.routes.draw do

  api vendor_string: 'loki', default_version: 1, path: '' do
    version 1 do
      cache as: 'v1' do
        root 'api#index'

        resources :artists, :except => :edit do
          resources :albums, :except => :edit
        end

        resources :albums, :only => [:index, :show] do
          resource :artist, :only => [:show]
        end

        resources :genres, :except => :edit do
          resources :albums, :only => [:index, :show]
          resources :artists, :only => [:index, :show]
        end
      end
    end
  end

  match '*url', via: [:get, :post, :put, :delete], :to => 'api#routing_error'
end