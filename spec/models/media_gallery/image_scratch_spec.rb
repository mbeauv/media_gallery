require 'rails_helper'

module MediaGallery
  RSpec.describe ImageScratch, type: :model do

    before do
      @user = build(:user)
    end

    it 'is valid with all info' do
      expect(build(:image_scratch)).to be_valid
    end

    it 'is valid with missing image_version' do
      expect(build(:image_scratch, image_version: nil)).to be_valid
    end

    it 'is not valid without an ownable' do
      expect(build(:image_scratch, ownable: nil)).not_to be_valid
    end
  end
end
