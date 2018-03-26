require_dependency "media_gallery/application_controller"
require "media_gallery/image_processing"

module MediaGallery
  class ImageScratchesController < ApplicationController

    # GET /image_scratches
    def index
      raise CanCan::AccessDenied.new unless current_user
      @scratches = ImageScratch.where(ownable: current_user).all
      (authorize! :read, @scratches[0]) unless @scratches.empty?
    end

    # POST /image_scratches
    def create
      ImageScratch.where(ownable: current_user).destroy_all

      # The persistence code that follows is suboptimal.  I'm a bit tired
      # right now.  Don't see it. Needs to be fixed.  Issue should be raised.
      # TODO Raise issue here.
      ActiveRecord::Base.transaction do
        @scratch = ImageScratch.new(ownable: current_user);
        authorize! :create, @scratch
        @scratch.save!
        @scratch.image_version = ImageVersion.new(image: image_scratch_params[:image], ownable: @scratch);
        @scratch.save!
      end

    end

    # DELETE /image_scratches/1
    def destroy
      ImageScratch.destroy_all(ownable: current_user)
    end

    private
    # Only allow a trusted parameter "white list" through.
    def image_scratch_params
      params.require(:image_scratch).permit(:image)
    end
  end
end
