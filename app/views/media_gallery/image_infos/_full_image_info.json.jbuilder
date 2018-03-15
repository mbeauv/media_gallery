json.id image_info.id
json.label image_info.label
json.galleryId image_info.gallery.id
json.galleryName image_info.gallery.name
json.description image_info.description
json.createdAt image_info.created_at
json.partial! 'image_versions', image_info: image_info
