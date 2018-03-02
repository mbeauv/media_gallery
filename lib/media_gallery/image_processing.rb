module MediaGallery

  module ImageProcessing

    # Helper method that processes a b64 encoded image and returns
    # the equivalent binary object.
    def self.create_photo_file data, photo_params
      imageContent = Base64.decode64(data)
      tempfile = Tempfile.new("photoupload")
      tempfile.binmode
      tempfile << imageContent
      tempfile.rewind
      photo_params = photo_params.merge(:tempfile => tempfile)
      photo = ActionDispatch::Http::UploadedFile.new(photo_params)
      photo.original_filename = "photofile"
      photo
    end

  end
end
