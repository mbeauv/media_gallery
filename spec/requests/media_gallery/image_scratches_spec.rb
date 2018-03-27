describe "ImageScratches API", :type => :request do

  before do
    @base_url = '/media_gallery/image_scratches'
    @user = create(:user)
    @b64_image = "R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs="
  end

  describe 'when creating' do

    it 'returns 403 error when anonymous' do
      post "#{@base_url}.json", params: {
        image_scratch: {
          image: @b64_image
        }
      }
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 200 OK when user exists' do
      post "#{@base_url}.json", params: {
        image_scratch: {
          image: @b64_image
        }
      }, headers: { 'token' => @user.token }

      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json.delete(:variants)).not_to be_nil

      scratch = MediaGallery::ImageScratch.where(id: json[:id]).first
      expect(json).to eq({
        id: scratch.id,
        imageVersionId: scratch.image_version.id
      })
    end
  end

  describe 'when showing all' do

    it 'returns 403 when anonymous' do
      get "#{@base_url}.json"
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 200 when user exists and associated scratch present' do
      scratch = create(:image_scratch)
      get "#{@base_url}.json", headers: { 'token' => scratch.ownable.token }
      expect(response).to have_http_status(200)
    end

  end

end
