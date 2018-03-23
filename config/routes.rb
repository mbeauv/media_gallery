MediaGallery::Engine.routes.draw do
  resources :image_scratches, only: [ :create, :index, :destroy ]
  resources :galleries do
    resources :image_infos
  end
end
