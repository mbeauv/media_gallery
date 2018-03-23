json.id @scratch.id
json.version_id @scratch.image_version.id
json.versions do
  json.array! @scratch.image_version.image.versions do |key, version|
    json.name key
    json.url version.url
  end
end
