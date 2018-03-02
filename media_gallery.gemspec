$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "media_gallery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "media_gallery"
  s.version     = MediaGallery::VERSION
  s.authors     = ["Martin Beauvais"]
  s.email       = ["mbeauv@gmail.com"]
  s.homepage    = "https://github.com/mbeauv/media_gallery"
  s.summary     = "Allows for the storage of images on S3 on a gallery basis."
  s.description = "Offers a REST interface allowing the management of S3 images on a gallery basis."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"
  s.add_dependency "carrierwave"
  s.add_dependency "fog"
  s.add_dependency "mini_magick"
  s.add_dependency "cancancan"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency "pg"

end
