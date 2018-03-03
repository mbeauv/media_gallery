# MediaGallery
This gem provides a Rails engine that allows for the storage of images on Amazon S3.  Images are organized in galleries.  All interactions are done through a simple REST API.

## Usage
As this is a Rails engine, you need to first mount the engine.  This can be done by modifying your config/routes.rb file.  You should add a mount point, something like:

```ruby
mount MediaGallery::Engine => "/media_gallery"
```

Next, you need to deal with access control. The media_gallery engine uses [cancancan](https://github.com/CanCanCommunity/cancancan) for access_control. It does not make any assumptions as to what library or method you use for sign in.  It works fine with [Devise](https://github.com/plataformatec/devise) if that is what you are using.  Simple JWT access should also be no problem.  You do need to override two methods in the MediaGallery::ApplicationController class.  These methods are:

- current_user:  Returns the current user
- create_ability: Returns an cancan Ability class for use in the media_gallery.  It can be your app's defined ability.

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
You can check the test app's initializer [here](https://github.com/mbeauv/media_gallery/blob/master/spec/dummy/config/initializers/media_gallery_initializer.rb).  You can also look at an example of how this can be done with Devise [here](https://github.com/mbeauv/media_gallery/wiki/Integration-with-Devise).

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

If you want to help out, no problem. The more, the merrier.  You can fix issues if you want to or look at the list of outstanding features here.

Make sure that you write unit tests. We presently have model and request specs.  The request specs require you to have an AWS account with S3 setup correctly.  You then need to define three environment variables:

- MEDIA_GALLERY_TEST_AWS_PUBLIC
- MEDIA_GALLERY_TEST_AWS_SECRET
- MEDIA_GALLERY_TEST_AWS_DIR

The rspecs look for these variables in your environment.  On Linux or Mac, you can add something like this to you .bash_profile

```bash
export MEDIA_GALLERY_TEST_AWS_PUBLIC=AJEJEKNJE87JS 
export MEDIA_GALLERY_TEST_AWS_SECRET=Bskljfslkdjflksjflkjslls+sljksjlk
export MEDIA_GALLERY_TEST_AWS_DIR=gallery2018
```

(All values provided in the previous block are fake... obviously :-)


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
