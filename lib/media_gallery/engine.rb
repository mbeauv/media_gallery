require 'cancancan'

module MediaGallery
  class Engine < ::Rails::Engine
    isolate_namespace MediaGallery
    config.generators.api_only = true
  end
end
