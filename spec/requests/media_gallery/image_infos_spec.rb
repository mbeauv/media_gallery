describe "ImageInfos API", :type => :request do

  before do
    @B64_IMAGE = "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs="
    @user = create(:user)
    @gallery = create(:gallery, ownable: @user)
  end

  it 'gets a list of image infos' do
    image1 = create(:image_info, gallery: @gallery, label: 'image1')
    image2 = create(:image_info, gallery: @gallery, label: 'image2')
    image3 = create(:image_info, gallery: @gallery, label: 'image3')

    get "/media_gallery/galleries/#{@gallery.id}/image_infos.json", params: {}, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.each { |image| image.delete(:urls) }

    expect(json).to eq(
      [
        { id: image1.id, label: image1.label },
        { id: image2.id, label: image2.label },
        { id: image3.id, label: image3.label }
      ]
    )
  end

  it 'gets one image info' do
    image1 = create(:image_info, gallery: @gallery, label: 'image1')

    get "/media_gallery/galleries/#{@gallery.id}/image_infos/#{image1.id}.json", params: {}, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.delete(:urls)
    json.delete(:createdAt)
    expect(json).to eq(
      {
        id: image1.id,
        label: image1.label,
        galleryId: @gallery.id,
        galleryName: @gallery.name,
        description: 'an image info description'
      })
  end

  it 'deletes an existing image info' do
    image1 = create(:image_info, gallery: @gallery, label: 'image1')
    delete "/media_gallery/galleries/#{@gallery.id}/image_infos/#{image1.id}.json", params: {}, headers: { 'token' => @user.token }
    expect(response).to be_success
    expect(MediaGallery::ImageInfo.exists?(image1.id)).to eq(false)
  end

  it 'updates an existing gallery' do
    image1 = create(:image_info, gallery: @gallery, label: 'image1')

    put "/media_gallery/galleries/#{@gallery.id}/image_infos/#{image1.id}.json", params: { image_info: { description: "updated description" } }, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.delete(:createdAt)
    json.delete(:urls)
    expect(json).to eq(
      {
        id: image1.id,
        label: image1.label,
        description: "updated description",
        galleryId: @gallery.id,
        galleryName: @gallery.name
      })
  end

  it 'creates a new image_info' do
    post "/media_gallery/galleries/#{@gallery.id}/image_infos.json", params: {
      image_info: {
        label: "jdoe_image",
        description: "a description",
        image: @B64_IMAGE
      }
    }, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.delete(:createdAt)
    json.delete(:urls)

    image = MediaGallery::ImageInfo.where(id: json[:id], label: 'jdoe_image', description: 'a description').first
    expect(json).to eq(
      {
        id: image.id,
        label: image.label,
        galleryId: image.gallery.id,
        galleryName: image.gallery.name,
        description: image.description
      })
  end

end
