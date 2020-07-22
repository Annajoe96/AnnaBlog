require 'rails_helper'

RSpec.describe UserPublication, type: :model do
  it 'has a valid Factory' do
    user = create(:user)
    create(:user_publication, email: user.email).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:publication) }
  end

  describe 'validations' do
    it { expect validate_presence_of(:user) }
    it { expect validate_presence_of(:publication) }
  end


end
