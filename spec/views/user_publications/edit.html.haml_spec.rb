require 'rails_helper'

RSpec.describe "user_publications/edit", type: :view do
  before(:each) do
    @user_publication = assign(:user_publication, UserPublication.create!())
  end

  it "renders the edit user_publication form" do
    render

    assert_select "form[action=?][method=?]", user_publication_path(@user_publication), "post" do
    end
  end
end
