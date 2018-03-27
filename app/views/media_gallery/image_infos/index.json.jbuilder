json.array! @gallery.image_infos.order(name: :asc) do |image_info|
  json.id image_info.id
  json.name image_info.name
  json.originalUrl image_info.image_version.image.url
  json.partial! 'image_versions', image_info: image_info
end
