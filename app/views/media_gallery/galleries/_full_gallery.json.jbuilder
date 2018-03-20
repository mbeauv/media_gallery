json.id gallery.id
json.name gallery.name
json.description gallery.description
json.createdAt gallery.created_at
json.imageInfos do
  json.array! gallery.image_infos do |image_info|
    json.id image_info.id
    json.label image_info.label
    json.url image_info.image.url(:thumb_tile)
    json.createdAt image_info.created_at
  end
end
