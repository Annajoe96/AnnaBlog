require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { User.create(firstname: "bob", lastname: "alex", email:"bob@gmail.com") }
  let(:article) { Article.create(user: user, title:"gasfghjsdfkehgj", body: "Do am he horrible distance marriage so although. Afraid assure square so happen mr an before. His many same been well can high that. Forfeited did law eagerness allowance improving assurance bed. Had saw put seven joy short first. Pronounce so enjoyment my resembled in forfeited" )}
  subject {
    described_class.new(user: user, comment: "good job", article: article)
  }

  it "is not valid when comment is empty" do
    subject.comment = nil
    expect(subject).to_not be_valid
  end

  it "is not valid when user is empty" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "is not valid when article is empty" do
    subject.article = nil
    expect(subject).to_not be_valid
  end

  it "is valid with all valid attributes" do
    expect(subject).to be_valid
  end


end
