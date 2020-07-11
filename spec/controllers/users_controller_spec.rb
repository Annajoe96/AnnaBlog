require 'rails_helper'

RSpec.describe UsersController do
  #Factories
  let(:user) { create(:user) }

  #methods
  def get_show
    get :show, params: {id: user.id}
  end

  describe "GET show" do
    context "user signed in" do
      it "shows user page" do
        sign_in user
        expect(get_show).to render_template(:show)
      end
    end
    context "user signed out" do
      it "shows user page" do
        expect(get_show).to render_template(:show)
      end
    end
  end





end
