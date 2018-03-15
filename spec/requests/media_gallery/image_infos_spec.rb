describe "ImageInfos API", :type => :request do

  BASE_URL = '/media_gallery/galleries'

  before do
    @B64_IMAGE = "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs="
    @gallery1 = create(:gallery)
  end

  describe 'when showing all' do

    it 'returns 403 error when anonymous' do
      delete "#{BASE_URL}/#{@gallery1.id}.json"
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied')
    end

    it 'returns 403 error when resource not present'  do
      delete "#{BASE_URL}/#{@gallery1.id + 11}.json", headers: { 'token' => @gallery1.ownable.token }
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq("Access Denied")
    end

    it 'return 200 OK when resources are ok' do
      image1 = create(:image_info, gallery: @gallery1, label: 'b')
      image2 = create(:image_info, gallery: @gallery1, label: 'c')
      image3 = create(:image_info, gallery: @gallery1, label: 'a')

      get "#{BASE_URL}/#{@gallery1.id}/image_infos.json", params: {}, headers: { 'token' => @gallery1.ownable.token }

      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.each { |image| image.delete(:versions) }

      expect(json).to eq(
        [
          { id: image3.id, label: image3.label },
          { id: image1.id, label: image1.label },
          { id: image2.id, label: image2.label }
        ]
      )
    end

  end

  describe 'when showing' do

    it '200 OK when resource exists' do
      image1 = create(:image_info, gallery: @gallery1, label: 'image1')

      get "#{BASE_URL}/#{@gallery1.id}/image_infos/#{image1.id}.json", params: {}, headers: { 'token' => @gallery1.ownable.token }

      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.delete(:versions)
      json.delete(:createdAt)
      expect(json).to eq(
        {
          id: image1.id,
          label: image1.label,
          galleryId: @gallery1.id,
          galleryName: @gallery1.name,
          description: 'an image info description'
        })
    end

  end

  describe 'when updating' do

    it 'returns 200 OK when resource exists' do
      image1 = create(:image_info, gallery: @gallery1, label: 'image1')

      put "/media_gallery/galleries/#{@gallery1.id}/image_infos/#{image1.id}.json", params: { image_info: { description: "updated description" } }, headers: { 'token' => @gallery1.ownable.token }

      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.delete(:createdAt)
      json.delete(:versions)
      expect(json).to eq(
        {
          id: image1.id,
          label: image1.label,
          description: "updated description",
          galleryId: @gallery1.id,
          galleryName: @gallery1.name
        })
    end

  end

  describe 'when deleting' do

    it 'returns 403 error when anonymous' do
      delete "#{BASE_URL}/#{@gallery1.id}.json"
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied')
    end

    it 'returns 403 error when resource not present' do
      delete "#{BASE_URL}/#{@gallery1.id + 11}.json", headers: { 'token' => @gallery1.ownable.token }
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq("Access Denied")
    end

    it 'returns 200 OK when resource exists' do
      image1 = create(:image_info, gallery: @gallery1, label: 'image1')
      delete "/media_gallery/galleries/#{@gallery1.id}/image_infos/#{image1.id}.json", params: {}, headers: { 'token' => @gallery1.ownable.token }
      expect(response).to be_success
      expect(MediaGallery::ImageInfo.exists?(image1.id)).to eq(false)
    end

  end

  describe 'when creating' do

    it 'returns 200 OK when resource exists' do
      post "/media_gallery/galleries/#{@gallery1.id}/image_infos.json", params: {
        image_info: {
          label: "jdoe_image",
          description: "a description",
          image: @B64_IMAGE
        }
      }, headers: { 'token' => @gallery1.ownable.token }

      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.delete(:createdAt)
      json.delete(:versions)

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
end
