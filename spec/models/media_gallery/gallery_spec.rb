require 'rails_helper'

module MediaGallery
  RSpec.describe Gallery, type: :model do

    it 'is valid with all info' do
      expect(build(:gallery)).to be_valid
    end

    it 'is not valid without a name' do
      expect(build(:gallery, name: nil)).not_to be_valid
    end

    it 'is not valid with an owner' do
      expect(build(:gallery, ownable: nil)).not_to be_valid
    end

    it 'is valid without a description' do
      expect(build(:gallery, description: nil)).to be_valid
    end

    it 'is not valid with a description greater than 1024 characters' do
      expect(build(:gallery, description: 'a' * 1025)).not_to be_valid
    end

    it 'cascades deletion to the image_infos' do
      gallery = create(:gallery)
      image_info = create(:image_info, gallery: gallery)
      expect { gallery.destroy }.to change { ImageInfo.count }.from(1).to(0)
    end

  end
end
