require 'rails_helper'

module MediaGallery
  RSpec.describe ImageVersion, type: :model do

    it 'is valid with all info' do
      expect(build(:image_version)).to be_valid
    end

    it 'is not valid without an owner' do
      expect(build(:image_version, ownable: nil)).not_to be_valid
    end

  end
end
