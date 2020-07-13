require 'rails_helper'

RSpec.describe Comment, type: :model do

  it 'has a valid Factory' do
    build(:comment).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end

  describe 'validations' do
    it { expect validate_presence_of(:comment) }
    it { expect validate_presence_of(:article) }
  end


end
