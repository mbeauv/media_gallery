describe "Galleries API", :type => :request do

  def token_header(gallery)
    { 'token': gallery.ownable.token }
  end

  before do
    @base_url = "/media_gallery/galleries"
  end

  describe "when showing all" do

    before do
      @gallery1 = create(:gallery)
      @gallery2 = create(:gallery, ownable: @gallery1.ownable)
      @gallery3 = create(:gallery, ownable: @gallery1.ownable)
    end

    it 'returns 403 error when anonymous' do
     get "#{@base_url}.json"
     expect(response).to have_http_status(403)
     json = JSON.parse(response.body, { symbolize_names: true })
     expect(json[:message]).to eq('Access Denied.')
   end

    it 'returns 200 when user (normal)' do
      get "#{@base_url}.json", params: {}, headers: token_header(@gallery1)
      expect(response).to be_success
      expect(JSON.parse(response.body, { symbolize_names: true })).to eq(
        [
          {
            id: @gallery1.id,
            name: @gallery1.name,
            description: @gallery1.description,
            nbImages: 0,
            createdOn: '2018-03-31T10:36:57.813Z',
            updatedOn: '2018-03-31T11:36:57.813Z'
          },
          {
            id: @gallery2.id,
            name: @gallery2.name,
            description: @gallery2.description,
            nbImages: 0,
            createdOn: '2018-03-31T10:36:57.813Z',
            updatedOn: '2018-03-31T11:36:57.813Z'
          },
          {
            id: @gallery3.id,
            name: @gallery3.name,
            description: @gallery3.description,
            nbImages: 0,
            createdOn: '2018-03-31T10:36:57.813Z',
            updatedOn: '2018-03-31T11:36:57.813Z'
           }
        ]
      )
    end

  end

  describe "when showing" do

    before do
      @gallery1 = create(:gallery)
    end

    it 'returns 403 error when anonymous' do
      get "#{@base_url}/#{@gallery1.id}.json"
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 403 error when resource not present' do
      get "#{@base_url}/#{@gallery1.id + 11}.json", headers: token_header(@gallery1)
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 200 when resource is present' do
      get "#{@base_url}/#{@gallery1.id}.json", params: {}, headers: token_header(@gallery1)
      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.delete(:createdAt)
      expect(json).to eq(
        {
          id: @gallery1.id,
          name: @gallery1.name,
          description: 'a test gallery',
          nbImages: 0,
          createdOn: '2018-03-31T10:36:57.813Z',
          updatedOn: '2018-03-31T11:36:57.813Z'
        })
    end

  end

  describe 'when updating' do

    before do
      @gallery1 = create(:gallery)
    end

    it 'returns 403 when not owner of resource' do
      user = create(:user)
      put "#{@base_url}/#{@gallery1.id}.json", headers: { token: user.token }
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 403 error when anonymous' do
      put "#{@base_url}/#{@gallery1.id}.json"
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 200 when resource is valid' do
      put "/media_gallery/galleries/#{@gallery1.id}.json", params: { gallery: { description: "updated description" } }, headers: token_header(@gallery1)
      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.delete(:updatedOn)
      expect(json).to eq(
        {
          id: @gallery1.id,
          name: @gallery1.name,
          description: "updated description",
          nbImages: 0,
          createdOn: '2018-03-31T10:36:57.813Z'
        }
      )
    end

  end

  describe "when deleting" do

    before do
      @gallery1 = create(:gallery)
    end

    it 'returns 403 error when anonymous' do
      delete "#{@base_url}/#{@gallery1.id}.json"
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 403 error when resource not present' do
      delete "#{@base_url}/#{@gallery1.id + 11}.json", headers: { 'token' => @gallery1.ownable.token }
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq("Access Denied.")
    end

    it 'returns 200 when resource type is present' do
      delete "#{@base_url}/#{@gallery1.id}.json", params: {}, headers: token_header(@gallery1)
      expect(response).to be_success
      expect(MediaGallery::Gallery.exists?(@gallery1.id)).to eq(false)
    end

  end

  describe 'when creating' do

    it 'returns 403 error when anonymous' do
      post "/media_gallery/galleries.json", params: {
        gallery: {
          name: "jdoe_gallery",
          description: "a description"
        }
      }
      expect(response).to have_http_status(403)
      json = JSON.parse(response.body, { symbolize_names: true })
      expect(json[:message]).to eq('Access Denied.')
    end

    it 'returns 200 when data is valid' do
      user = create(:user)
      post "/media_gallery/galleries.json", params: {
        gallery: {
          name: "jdoe_gallery",
          description: "a description"
        }
      }, headers: { 'token' => user.token }

      expect(response).to be_success
      json = JSON.parse(response.body, { symbolize_names: true })
      json.delete(:createdOn)
      json.delete(:updatedOn)

      gallery = MediaGallery::Gallery.where(id: json[:id], name: 'jdoe_gallery', description: 'a description').first
      expect(gallery).not_to be_nil
      expect(json).to eq(
        {
          id: gallery.id,
          name: gallery.name,
          description: gallery.description,
          nbImages: 0
        }
      )
    end
  end
end
