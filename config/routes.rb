MediaGallery::Engine.routes.draw do
  resources :galleries do
    resources :image_infos
  end
end
