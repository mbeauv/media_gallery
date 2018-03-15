json.versions do
  json.array! image_info.image.versions do |key, version|
    json.name key
    json.url version.url
  end
end
