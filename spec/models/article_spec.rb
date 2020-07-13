require 'rails_helper'

RSpec.describe Article, :type => :model do

  it 'has a valid Factory' do
    build(:article).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end


  describe 'validations' do
    it { expect validate_presence_of(:title) }
    it { expect validate_presence_of(:body) }
    it { expect validate_length_of(:body).is_at_least(10) }
  end


  describe 'methods' do
    it "word_count" do
      article = create(:article, body: "hello my name is anna joe I like clothes and chocolates twelve thireteen fourteen")
      expect(article.word_count).equal?("14")
    end
  end


end
