require_dependency "media_gallery/application_controller"

module MediaGallery
  class GalleriesController < ApplicationController

    load_and_authorize_resource except: [ :index, :create ]

    # GET /galleries
    def index
      @galleries = Gallery.where(ownable: current_user).order(name: :asc)
      authorize! :read, @galleries[0] if @galleries.length > 0
    end

    # POST /galleries
    def create
      @gallery = Gallery.new(
        name: gallery_params[:name],
        ownable: current_user,
        description: gallery_params[:description]
      )
      authorize! :create, @gallery
      @gallery.save!
    end

    # GET /galleries/1
    def show
      authorize! :read, @gallery
    end

    # PATCH/PUT /galleries/1
    def update
      authorize! :update, @gallery
      @gallery.update_attributes!(gallery_params)
    end

    # DELETE /galleries/1
    def destroy
      @gallery.destroy
    end

    private

    # Only allow a trusted parameter "white list" through.
    def gallery_params
      params.require(:gallery).permit(:name, :description)
    end

  end
end
