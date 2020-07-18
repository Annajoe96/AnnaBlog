require 'rails_helper'

RSpec.describe "user_publications/index", type: :view do
  before(:each) do
    assign(:user_publications, [
      UserPublication.create!(),
      UserPublication.create!()
    ])
  end

  it "renders a list of user_publications" do
    render
  end
end
