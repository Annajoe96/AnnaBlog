require 'rails_helper'

RSpec.describe Article, :type => :model do
  let(:user) { User.create(firstname: "bob", lastname: "alex", email:"bob@gmail.com") }
  subject {
    described_class.new(user: user, title:"gasfghjsdfkehgj", body: "Do am he horrible distance marriage so although. Afraid assure square so happen mr an before. His many same been well can high that. Forfeited did law eagerness allowance improving assurance bed. Had saw put seven joy short first. Pronounce so enjoyment my resembled in forfeited sportsman. Which vexed did began son abode short may. Interested astonished he at cultivated or me. Nor brought one invited she produce her.")
  }

  it "is not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with body less than 10 words" do
    subject.body = "helloo hi"
    expect(subject).to_not be_valid
  end

  it "is not valid without both title and body" do
    subject.title = nil
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "is valid with both valid title and body" do
    expect(subject).to be_valid
  end

end
