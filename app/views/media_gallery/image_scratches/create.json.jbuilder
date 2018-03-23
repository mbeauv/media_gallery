json.id @scratch.id
json.imageVersionId @scratch.image_version.id
json.variants do
  json.array! @scratch.image_version.image.versions do |key, version|
    json.name key
    json.url version.url
  end
end
