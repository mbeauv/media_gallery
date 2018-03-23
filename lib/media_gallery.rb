require "media_gallery/engine"
require "carrierwave"

module MediaGallery

  # Exception generated when the user does not have a scratch image
  # when it is required.
  class ScratchImageEmpty < StandardError
  end

end
