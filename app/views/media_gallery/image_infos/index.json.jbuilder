json.array! @gallery.image_infos.order(label: :asc) do |image_info|
  json.id image_info.id
  json.label image_info.label
  json.partial! 'image_urls', image_info: image_info
end
