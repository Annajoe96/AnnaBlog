require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(email:"abcdefgh@gmail.com", firstname: "sarah" , lastname: "jessica")
  }

  it "is not valid without all attributes" do
    subject.email = nil
    subject.firstname = nil
    subject.lastname = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without first name" do
    subject.firstname = nil
    expect(subject).to_not be_valid
  end

  it "is not without last name" do
    subject.lastname = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not non-unique email id" do
    subject.email = "danielpaul@gmail.com"
    expect(subject).to_not be_valid
  end

  it "full name joins first name and last name" do
    expect(subject.full_name).equal?("sarah jessica")
  end

end
