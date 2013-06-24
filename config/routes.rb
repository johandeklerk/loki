Loki::Application.routes.draw do
  api vendor_string: 'loki', default_version: 1, path: '' do
    version 1 do
      cache as: 'v1' do
        root 'api#index'
        resources :artists
      end
    end
  end
end
