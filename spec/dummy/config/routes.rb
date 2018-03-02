Rails.application.routes.draw do
  resources :users
  mount MediaGallery::Engine => "/media_gallery"
end
