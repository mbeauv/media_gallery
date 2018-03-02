json.array! @galleries do |gallery|
  json.id gallery.id
  json.name gallery.name
  json.nbImages gallery.image_infos.size
end
