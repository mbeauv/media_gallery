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
      @image_info = use_scratch?(params) ?
                      process_with_scratch(params, @gallery) :
                      process_with_image(params, @gallery)
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

    # Verifies if the image version saved in the user's scratch pad should
    # be used.
    def use_scratch?(params)
      params[:use_scratch] && params[:use_scratch] == 'true'
    end

    # Only allow a trusted parameter "white list" through.
    def image_info_params
      params.require(:image_info).permit(:label, :description, :image)
    end

    def process_with_image(params, gallery)
      ActiveRecord::Base.transaction do
        image_info = ImageInfo.create!(
          label: image_info_params[:label],
          description: image_info_params[:description],
          gallery: gallery
        )
        ImageVersion.create!(image: image_info_params['image'], ownable: image_info)
        authorize! :create, image_info
        image_info.save!
        image_info
      end
    end

    def process_with_scratch(params, gallery)
      image_scratch = ImageScratch.where(ownable: current_user).first
      raise MediaGallery::ScratchImageEmpty unless image_scratch;

      image_info = ImageInfo.new(
        label: image_info_params[:label],
        description: image_info_params[:description],
        gallery: gallery,
        image_version: image_scratch.image_version
      )

      ActiveRecord::Base.transaction do
        image_scratch.update(image_version: nil);
        image_scratch.destroy
        authorize! :create, image_info
        image_info.save!
        image_info
      end
    end
  end
end
