require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid Factory' do
    build(:user).should be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'validations' do
    it "full name joins first name and last name" do
      user = create(:user, firstname: "sarah", lastname: "jessica")
      expect(user.full_name).equal?("sarah jessica")
    end
  end

end
