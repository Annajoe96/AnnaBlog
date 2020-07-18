require 'rails_helper'

RSpec.describe "user_publications/show", type: :view do
  before(:each) do
    @user_publication = assign(:user_publication, UserPublication.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
