json.array! @gallery.image_infos.order(name: :asc) do |image_info|
  json.partial! 'image_info', image_info: image_info
end
