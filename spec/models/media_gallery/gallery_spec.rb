require 'rails_helper'

module MediaGallery
  RSpec.describe Gallery, type: :model do

    before do
      @user = build(:user)
    end

    it 'is valid with all info' do
      expect(build(:gallery, ownable: @user)).to be_valid
    end

    it 'is not valid without a name' do
      expect(build(:gallery, name: nil, ownable: @user)).not_to be_valid
    end

    it 'is not valid with an owner' do
      expect(build(:gallery)).not_to be_valid
    end

    it 'is valid without a description' do
      expect(build(:gallery, description: nil, ownable: @user)).to be_valid
    end

    it 'is not valid with a description greater than 1024 characters' do
      expect(build(:gallery, description: 'a' * 1025, ownable: @user)).not_to be_valid
    end

  end
end
