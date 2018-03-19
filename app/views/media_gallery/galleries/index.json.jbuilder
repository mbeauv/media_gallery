json.array! @galleries do |gallery|
  json.partial! 'partial_gallery', gallery: gallery
end
