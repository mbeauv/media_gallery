# MediaGallery
This gem provides a Rails engine allowing for the storage of images on Amazon S3.  Images are organized in galleries.  All interactions are done through a simple REST API.

## Usage
This section goes over the internals of the engine (i.e. how to integrate it) and the REST API itself (io.e. how to interact with the gallery).  It also describes how to run the unit and integration tests (if you so desire).

### Internals
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
### REST API
The media_gallery uses a straightforward REST mechanism.  Here are a few samples:

#### Creating gallery

```json
Request -> POST .../media_gallery/galleries
{
	"gallery": {
		"description": "an updated text for description."		
	}
}

Response ->
{
    "id": 1,
    "name": "jdoe_gallery",
    "description": "stores images for joe doe",
    "nbImages": 0,
    "createdAt": "2018-03-02T14:13:19.805Z"
}
```

#### Updating a gallery

```json
Request -> PUT .../media_gallery/galleries/1
{
  "name": "jdoe_gallery",
  "description": "stores images for joe doe"
}

Response ->
{
    "id": 1,
    "ownable_id": 1,
    "ownable_type": "User",
    "description": "an updated text for description.",
    "name": "jdoe_gallery",
    "created_at": "2018-03-01T14:20:48.117Z",
    "updated_at": "2018-03-01T14:21:38.612Z"
}
```

#### Deleting a gallery

```json
Request -> DELETE .../media_gallery/galleries/1
Response -> (Standard HTTP code, basically 200 or something equivalent)
```



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

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
