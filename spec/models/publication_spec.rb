require 'rails_helper'

RSpec.describe Publication, type: :model do

  it 'has a valid Factory' do
    create(:publication).should be_valid
  end

  describe 'associations' do
    it { should have_many(:user_publications) }
    it { should have_many(:users) }
  end

  describe 'validations' do
    it { expect validate_presence_of(:title) }
    it { expect validate_presence_of(:description) }
  end



end
