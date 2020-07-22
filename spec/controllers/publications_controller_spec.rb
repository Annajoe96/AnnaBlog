require 'rails_helper'

RSpec.describe PublicationsController do
  #----- FACTORIES -----#
  let(:publication) { create(:publication) }
  let(:user) { create(:user) }
  #----- METHODS -----#
  def get_index
    get :index
  end

  def get_new
    get :new
  end

  def post_create
    post :create, params: {publication: attributes_for(:publication)}
  end

  def get_show
    get :show, params: {id: publication}
  end

  def get_edit
    get :edit, params: {id: publication}
  end

  def put_update
    put :update, params: {id: publication, publication: attributes_for(:article, title: "Anna")}
  end

  def make_publication_with_member
    @new_publication = create(:publication)
    @new_user_publication = create(:user_publication, user_id: user.id, publication_id: @new_publication.id)
  end


  #----- TESTS-----#
  describe "GET index" do
    it "shows all publications" do
      expect(get_index).to render_template(:index)
    end
  end

  describe "GET new" do
    context "signed in user" do
      it "should render new" do
        sign_in user
        expect(get_new).to render_template(:new)
      end
    end
    context "signed out user" do
      it "should not render it" do
        expect(get_new).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST create" do
    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "with valid attributes" do
        it "should create a new publication" do
          expect{
            post_create
          }.to change(Publication, :count).by(1)
        end
        it "should redirect to publication path" do
          expect(post_create).to redirect_to publication_path(Publication.last)
        end

        it "should add to user-publication" do
          expect{
            post_create
          }.to change(UserPublication, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "should not create a publication with invalid title" do
          expect(post :create, params: {publication: attributes_for(:publication, title: nil)}).to render_template(:new)
        end
        it "should not create a new publication" do
          expect{
            post :create, params: {publication: attributes_for(:publication, title: nil)}
          }.to change(Publication, :count).by(0)
        end
      end
    end

    context "signed out user" do
      it "should redirect to user sign up " do
        expect(post_create).to redirect_to new_user_session_path
      end
      it "should not create publication" do
        expect{
          post_create
        }.to change(Publication, :count).by(0)
      end
    end
  end

  describe "GET show" do
    context "user signed in" do
      it "shows the publication" do
        sign_in user
        expect(get_show).to render_template(:show)
      end
    end
    context "user signed out" do
      it "shows the publication" do
        expect(get_show).to render_template(:show)
      end
    end
  end

  describe "GET edit" do
    context "user signed in" do
      context "is part of permission group" do
        it "shows edit page" do
          sign_in user
          make_publication_with_member
          expect(get :edit, params: {id: @new_publication}).to render_template(:edit)
        end
      end
      context "is not part of permisison group" do
        it "does not show edit page" do
          sign_in user
          expect(get_edit).not_to render_template(:edit)
        end
      end
    end
    context "user signed out" do
      it "redirects to login page" do
        expect(get_edit).to redirect_to new_user_session_path
      end
    end
  end

  describe "PUT update" do
    context "user signed in" do
      before(:example) do
        sign_in user
      end
      context "user is in permission list" do
        context "valid attributes" do
          it "redirects to publication page" do
            make_publication_with_member
            expect(put :update, params: {id: @new_publication, publication: attributes_for(:publication, title: "Anna")}).to redirect_to publication_path(Publication.last)
          end
          it "should update publication" do
            make_publication_with_member
            put :update, params: {id: @new_publication, publication: attributes_for(:publication, title: "Anna")}
            expect(Publication.find(@new_publication.id).title).to eq("Anna")
          end
        end
        context "invalid attributes" do
          it "renders to edit page" do
            make_publication_with_member
            expect(put :update, params: {id: @new_publication, publication: attributes_for(:publication, title: nil)}).to render_template(:edit)
          end
        end
      end
      context "is not article author" do
        it "does not update" do
          put_update
          expect(Publication.find(publication.id).title).not_to eq("Anna")
        end
      end
    end
    context "user not signed in" do
      it "redirects to login page" do
        expect(put_update).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE destroy" do
    context "user signed in" do
      before(:example) do
        sign_in user
      end
      context "user is in permission list" do
        it "should delete the publication" do
          make_publication_with_member
          expect{
            delete :destroy, params: {id: @new_publication}
          }.to change(Publication, :count).by(-1)
        end
        it "should go to index" do
          make_publication_with_member
          expect(delete :destroy, params: {id: @new_publication}).to redirect_to publications_url
        end
      end
      context "if user is not in permission list" do
        it "should not delete" do
          expect{
            delete :destroy, params: {id: publication}
          }.to change(Publication, :count).by(0)
        end
      end
    end
    context "not signed in" do
      it "redirects to login page" do
        expect(delete :destroy, params: {id: publication}).to redirect_to new_user_session_path
      end
    end
  end



end
