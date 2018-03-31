json.array! @galleries do |gallery|
  json.partial! 'gallery', gallery: gallery
end
