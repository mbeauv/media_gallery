require_dependency "media_gallery/application_controller"
require "media_gallery/image_processing"

module MediaGallery
  class ImageInfosController < ApplicationController

    load_and_authorize_resource :gallery
    load_and_authorize_resource :image_info, through: :gallery, except: [ :index, :create ]

    # GET /galleries/1/image_infos
    def index
    end

    # GET /galleries/1/image_infos/1
    def show
    end

    # POST /galleries/1/image_infos
    def create
      image_file = MediaGallery::ImageProcessing.create_photo_file(image_info_params['image'], {})
      @image_info = ImageInfo.new(
        label: image_info_params[:label],
        description: image_info_params[:description],
        gallery: @gallery,
        image: image_file
      )
      authorize! :create, @image_info
      @image_info.save!
    end

    # PATCH/PUT /galleries/1/image_infos/1
    def update
      authorize! :update, @image_info
      @image_info.update_attributes!(image_info_params)
    end

    # DELETE /galleries/1/image_infos/1
    def destroy
      @image_info.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def image_info_params
      params.require(:image_info).permit(:label, :description, :image)
    end
  end
end
