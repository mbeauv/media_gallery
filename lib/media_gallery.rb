require "media_gallery/engine"
require "carrierwave"

module MediaGallery

  # Exception generated when the user does not have a scratch image
  # when it is required.
  class ScratchImageEmpty < StandardError
  end

  # Exception generated when an image needs to be present in the
  # params section of the message (e.g. ImageInfoController::create).
  class ImageMissing < StandardError
  end

end
