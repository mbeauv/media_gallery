# encoding: utf-8
require 'carrierwave'
require 'carrierwave/base64'
require 'fog'
require 'carrierwave/orm/activerecord'

module MediaGallery
  class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :thumb do
      process :resize_to_fill => [300, 180]
    end

    version :thumb_high do
      process :resize_to_fill => [180, 300]
    end

    version :banner_square do
      process :resize_to_fill => [500, 500]
    end

    version :banner_main do
      process :resize_to_fill => [850, 425]
    end

    version :thumb_tile do
      process :resize_to_fill => [80, 80]
    end

  end

end
