json.array! @scratches do |scratch|
  json.id scratch.id
  json.versions do
    json.array! scratch.image_version.image.versions do |key, version|
      json.name key
      json.url version.url
    end
  end
end
