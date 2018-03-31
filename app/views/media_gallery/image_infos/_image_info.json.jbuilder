json.id image_info.id
json.name image_info.name
json.description image_info.description
json.createdOn image_info.created_at
json.updatedOn image_info.updated_at
json.originalUrl image_info.image_version.image.url
json.partial! 'image_variants', image_info: image_info
