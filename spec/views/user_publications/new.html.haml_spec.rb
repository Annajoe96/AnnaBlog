require 'rails_helper'

RSpec.describe "user_publications/new", type: :view do
  before(:each) do
    assign(:user_publication, UserPublication.new())
  end

  it "renders new user_publication form" do
    render

    assert_select "form[action=?][method=?]", user_publications_path, "post" do
    end
  end
end
