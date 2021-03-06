require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid Factory' do
    build(:user).should be_valid
  end

  describe 'associations' do
    it { should have_many(:articles) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should have_many(:publications) }
    it { should have_many(:user_publications) }
  end

  describe 'validations' do
    it { expect validate_presence_of(:password) }
    it { expect validate_presence_of(:firstname) }
    it { expect validate_presence_of(:lastname) }
    it { expect validate_presence_of(:email) }

    it { expect validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'methods' do
    it "full name joins first name and last name" do
      user = create(:user, firstname: "sarah", lastname: "jessica")
      expect(user.full_name).equal?("sarah jessica")
    end
  end

end
