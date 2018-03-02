json.urls do
  image = image_info.image
  image.versions.keys.each do |key|
    json.set! "#{key}", image.versions[key].url
  end
end
