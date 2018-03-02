# MediaGallery
This gem provides a Rails engine allowing for the storage of images on Amazon S3.  Images are organized in galleries.  All interactions are done through a simple REST API.

## Usage
As this is a Rails engine, you need to first mount the engine.  This can be done by modifying your config/routes.rb file.  You should add a mount point, something like:

```ruby
mount MediaGallery::Engine => "/media_gallery"
```

Next, you need to deal with access control. media_gallery uses cancancan for access_control. It does not make any assumptions as to what sign in strategy you use.  It should work fine with Devise if that's what you use.  There are two methods in the MediaGallerythat need to be overridden:

- current_user:  This method returns the current user
- create_ability: Returns an Ability class for use in the media_gallery.

The recommended approach for this is to create an initializer.  You can check out the one in spec/dummy app.  It defines something like:

```ruby
MediaGallery::ApplicationController.class_eval do

  def current_user
    User.find_by_token(request.headers['token'])
  end

  def create_ability(user)
    Ability.new(user)
  end
end
```

You can check some API samples on the wiki page.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'media_gallery'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install media_gallery
```

You'll also need to ensure that the associated migrations are run.  You can do this with the following:

```bash
bin/rails media_gallery:install:migrations
bin/rails db:migrate SCOPE=media_gallery
```
## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
