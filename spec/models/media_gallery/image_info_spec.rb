require 'rails_helper'

module MediaGallery
  RSpec.describe ImageInfo, type: :model do

    before do
      @user = build(:user)
      @gallery = build(:gallery, ownable: @user)
    end

    it 'is valid with all info' do
      expect(build(:image_info, gallery: @gallery)).to be_valid
    end

    it 'is not valid without a label' do
      expect(build(:image_info, label: nil, gallery: @gallery)).not_to be_valid
    end

    it 'is not valid with a label longer than 256 characters' do
      expect(build(:image_info, gallery: @gallery, label: 't' * 257)).not_to be_valid
    end

    it 'is not valid without a gallery' do
      expect(build(:image_info)).not_to be_valid
    end

    it 'is valid without a description' do
      expect(build(:image_info, description: nil, gallery: @gallery)).to be_valid
    end

    it 'is not valid with a description greater than 1024 characters' do
      expect(build(:image_info, gallery: @gallery, description: 'a' * 1025)).not_to be_valid
    end

  end
end
