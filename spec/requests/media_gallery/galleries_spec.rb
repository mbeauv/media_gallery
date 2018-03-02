describe "Galleries API", :type => :request do

  before do
    @user = create(:user)
    @admin = create(:user, admin: true)
    @disabled = create(:user, disabled: true)
  end

  it 'gets a list of galleries' do
    gallery1 = create(:gallery, ownable: @user)
    gallery2 = create(:gallery, ownable: @user)
    gallery3 = create(:gallery, ownable: @user)

    get "/media_gallery/galleries.json", params: {}, headers: { 'token' => @user.token }

    expect(response).to be_success
    expect(JSON.parse(response.body, { symbolize_names: true })).to eq(
      [
        { id: gallery1.id, name: gallery1.name, nbImages: 0 },
        { id: gallery2.id, name: gallery2.name, nbImages: 0 },
        { id: gallery3.id, name: gallery3.name, nbImages: 0 }
      ]
    )
  end

  it 'gets one gallery' do
    gallery1 = create(:gallery, ownable: @user)

    get "/media_gallery/galleries/#{gallery1.id}.json", params: {}, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.delete(:createdAt)
    expect(json).to eq({ id: gallery1.id, name: gallery1.name, nbImages: 0, description: 'a test gallery' })
  end

  it 'updates an existing gallery' do
    gallery1 = create(:gallery, ownable: @user)

    put "/media_gallery/galleries/#{gallery1.id}.json", params: { gallery: { description: "updated description" } }, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.delete(:createdAt)
    expect(json).to eq({ id: gallery1.id, name: gallery1.name, nbImages: 0, description: "updated description" })
  end

  it 'deletes an existing gallery' do
    gallery1 = create(:gallery, ownable: @user)
    delete "/media_gallery/galleries/#{gallery1.id}.json", params: {}, headers: { 'token' => @user.token }
    expect(response).to be_success
    expect(MediaGallery::Gallery.exists?(gallery1.id)).to eq(false)
  end

  it 'creates a new gallery' do
    post "/media_gallery/galleries.json", params: {
      gallery: {
        name: "jdoe_gallery",
        description: "a description"
      }
    }, headers: { 'token' => @user.token }

    expect(response).to be_success
    json = JSON.parse(response.body, { symbolize_names: true })
    json.delete(:createdAt)

    gallery = MediaGallery::Gallery.where(id: json[:id], name: 'jdoe_gallery', description: 'a description').first
    expect(gallery).not_to be_nil
    expect(json).to eq({ id: gallery.id, name: gallery.name, nbImages: 0, description: gallery.description })
  end

end
