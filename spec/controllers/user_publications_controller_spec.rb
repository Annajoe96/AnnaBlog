require 'rails_helper'

RSpec.describe UserPublicationsController do

  #----- FACTORIES -----#
  let(:user_publication) { create(:publication) }
  let(:publication) { create(:publication) }
  let(:user) { create(:user) }


  #----- METHODS -----#

  def get_index(pub_id)
    get :index, params: {publication_id: pub_id}
  end

  def get_new(pub_id)
    get :new, params: {publication_id: pub_id}
  end

  def post_create(pub_id)
    post :create, params: {publication_id: pub_id}
  end


  #-----TESTS-----#

  describe "GET index" do
    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "if user is member" do
        it "should redirect to index page" do
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)
          expect(get_index(@new_publication.id)).to render_template(:index)
        end
        it "should show list of members" do
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)
          get_index(@new_publication.id)
          expect(assigns(:user_publications).count).to eq(1)
        end
      end
      context "if user is not a member" do
        it "should not render index" do
          @user = create(:user)
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: @user.email)
          expect(get_index(@new_publication.id)).not_to render_template(:index)
        end
      end
    end
    context "signed out user" do
      it "should not render index" do
        @new_publication = create(:publication)
        expect(get_index(@new_publication.id)).not_to render_template(:index)
      end
      it "redirect to sign in page" do
        @new_publication = create(:publication)
        expect(get_index(@new_publication.id)).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET new" do
    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "user is a member" do
        it "should render add member page" do
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)
          expect(get_new(@new_publication.id)).to render_template(:new)
        end
      end
      context "is not a member" do
        it "should not render add member page" do
          @user = create(:user)
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: @user.email)
          expect(get_new(@new_publication.id)).not_to render_template(:new)
        end
      end
    end

    context "signed out user" do
      it "should not render add member page" do
        @new_publication = create(:publication)
        expect(get_new(@new_publication.id)).not_to render_template(:new)
      end
      it "should redirect to sign in page" do
        @new_publication = create(:publication)
        expect(get_new(@new_publication.id)).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST create" do
    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "Member adding users" do
        it "should increase number of members in publication" do
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)
          @user = create(:user)
          expect{
            post :create, params: {user_publication: {email: @user.email}, publication_id: @new_publication.id }
          }.to change(UserPublication, :count).by(1)
        end
        it "should redirect to index page" do
          @user = create(:user)
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)

          expect(
            post :create, params: {user_publication: {email: @user.email}, publication_id: @new_publication.id }
          ).to redirect_to publication_user_publications_path(@new_publication.id)
        end
        context "invalid email id" do
          it "should stay on the same page" do
            @new_publication = create(:publication)
            @new_user_publication = create(:user_publication, publication_id: @new_publication.id,email: user.email)
            expect(
              post :create, params: {user_publication: {email:"nnnn@gmail.com"}, publication_id: @new_publication.id }
            ).to render_template(:new)
          end
          it "should not increase number of members" do
            @new_publication = create(:publication)
            @new_user_publication = create(:user_publication, publication_id: @new_publication.id,email: user.email)
            expect{
              post :create, params: {user_publication: {email:"nnnn@gmail.com"}, publication_id: @new_publication.id }
            }.to change(UserPublication, :count).by(0)
          end
        end
      end

      context "non member adding users" do
        it "should not increase number of members in publication" do
          @user2 = create(:user)
          @user = create(:user)
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication,user_id: @user.id, publication_id: @new_publication.id, email: @user.email)
          expect{
            post :create, params: {user_publication: {email: @user2.email}, publication_id: @new_publication.id }
          }.to change(UserPublication, :count).by(0)
        end

        it "should render new page" do
          @user2 = create(:user)
          @user = create(:user)
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication,user_id: @user.id, publication_id: @new_publication.id, email: @user.email)
          expect(
            post :create, params: {user_publication: {email: @user2.email}, publication_id: @new_publication.id }
          ).not_to render_template(:new)
        end
      end
    end

    context "signed out user" do
      it "redirects to login page" do
        @user = create(:user)
        @new_publication = create(:publication)
        expect(post :create, params: {user_publication: {email:@user.email}, publication_id: @new_publication.id }).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE destroy" do
    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "member deleting users" do
        it "should reduce number of members" do
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)
          @user = create(:user)
          @user_publication = create(:user_publication, publication_id:  @new_publication.id, email: @user.email )
          expect{
            delete :destroy, params: {id: @user_publication.id , publication_id: @new_publication.id }
          }.to change(UserPublication, :count).by(-1)
        end
        it "should redirect to index page" do
          @new_publication = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: user.email)
          @user = create(:user)
          @user_publication = create(:user_publication, publication_id:  @new_publication.id, email: @user.email )
          expect(
            delete :destroy, params: {id: @user_publication.id , publication_id: @new_publication.id }
          ).to redirect_to publication_user_publications_path(@new_publication.id)
        end
      end
      context "non member deleting users" do
        it "shouldn't reduce number of members" do
          @user2 = create(:user)
          @user = create(:user)
          @new_publication = create(:publication)
          @new_publication_2 = create(:publication)
          @new_user_publication = create(:user_publication, publication_id: @new_publication_2.id, email: @user2.email)
          @user_publication = create(:user_publication, publication_id:  @new_publication.id, email: @user.email )
          expect{
            delete :destroy, params: {id: @user_publication.id , publication_id: @new_publication.id }
          }.to change(UserPublication, :count).by(0)
        end
      end
    end

    context "not signed in" do
      it "should redirect to user login page" do
        @user = create(:user)
        @new_publication = create(:publication)
        @new_user_publication = create(:user_publication, publication_id: @new_publication.id, email: @user.email)
        expect(
          delete :destroy, params: {id: @new_user_publication.id , publication_id: @new_publication.id }
        ).to redirect_to new_user_session_path
      end
    end
  end
end
