require 'rails_helper'

RSpec.describe ArticlesController do

  #-----FACTORIES-----#
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:publication) { create(:publication) }

  #-----METHODS-----#
  def get_index
    get :index
  end

  def get_new
    get :new
  end

  def post_create
    post :create, params: {article: attributes_for(:article)}
  end

  def get_show
    get :show, params: {id: article}
  end

  def get_edit
    get :edit, params: {id: article}
  end

  def put_update
    put :update, params: {id: article, article: attributes_for(:article, title: "Anna")}
  end


  #-----TESTS-----#
  describe "GET index" do
    it "shows all articles" do
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
        it "should create a new article" do
          expect{
            post_create
          }.to change(Article, :count).by(1)
        end
        it "should redirect to root path" do
          expect(post_create).to redirect_to(Article.last)
        end
      end

      context "part of publication" do
        it "should add new article to publication" do
          @new_publication = create(:publication)
          @user_publication = create(:user_publication, email: user.email, publication_id: @new_publication.id)
          expect{
            post :create, params: {article: attributes_for(:article, publication_id: @new_publication.id)}
          }.to change(Article.where(publication_id: @new_publication.id), :count).by(1)
        end
      end
      context "not part of publication" do
        it "shouldn't add with non-permission member" do
          @new_publication = create(:publication)
          expect{
            post :create, params: {article: attributes_for(:article, publication_id: @new_publication.id)}
          }.to change(Article.where(publication_id: @new_publication.id), :count).by(0)
        end
      end

      context "with invalid attributes" do
        it "should not create a article" do
          expect(post :create, params: {article: attributes_for(:article, title: nil)}).to render_template(:new)
        end
        it "should not create a new article" do
          expect{
            post :create, params: {article: attributes_for(:article, title: nil)}
          }.to change(Article, :count).by(0)
        end
      end
    end
    context "signed out user" do
      it "should redirect to user sign up " do
        expect(post_create).to redirect_to new_user_session_path
      end
      it "should not create article" do
        expect{
          post_create
        }.to change(Article, :count).by(0)
      end
      it "should not create article under publication" do
        expect{
          post_create
        }.to change(Article, :count).by(0)
      end
    end
  end

  describe "GET show" do
    context "user signed in" do
      it "shows the article" do
        sign_in user
        expect(get_show).to render_template(:show)
      end
    end
    context "user signed out" do
      it "shows the article" do
        expect(get_show).to render_template(:show)
      end
    end
  end

  describe "GET edit" do
    context "user signed in" do
      context "is article author" do
        it "shows edit page" do
          sign_in user
          new_article = create(:article, user_id: user.id)
          expect(get :edit, params: {id: new_article}).to render_template(:edit)
        end
      end
      context "not author" do
        it "does not show edit page" do
          sign_in user
          expect(get_edit).not_to render_template(:edit)
        end
      end

      context "article part of publication" do
        context "members of publication" do
          context "if author of article" do
            it "shows the edit page" do
              sign_in user
              @new_publication = create(:publication)
              @new_user_publication = create(:user_publication, email: user.email, publication_id: @new_publication.id)
              @article = create(:article, publication_id: @new_publication.id, user_id: @new_user_publication.user_id )
              expect(get :edit, params: {id: @article}).to render_template(:edit)
            end
          end
          context "if not author" do
            it "should not show edit page" do
              sign_in user
              new_user = create(:user)
              @new_publication = create(:publication)
              @new_user_publication = create(:user_publication, email: new_user.email , publication_id: @new_publication.id)
              @article = create(:article, publication_id: @new_publication.id, user_id: user.id  )
              expect(get :edit, params:{id: @article}).to redirect_to root_path
            end
          end
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
      context "is article author" do
        context "valid attributes" do
          it "redirects to the article page" do
            new_article = create(:article, user_id: user.id)
            expect(put :update, params: {id: new_article, article: attributes_for(:article, title: "Anna")}).to redirect_to(new_article)
          end
          it "should update article" do
            new_article = create(:article, user_id: user.id)
            put :update, params: {id: new_article, article: attributes_for(:article, title: "Anna")}
            expect(Article.find(new_article.id).title).to eq("Anna")
          end
        end
        context "invalid attributes" do
          it "renders to edit page" do
            new_article = create(:article, user_id: user.id)
            expect(put :update, params: {id: new_article, article: attributes_for(:article, title: nil)}).to render_template(:edit)
          end
        end
      end
      context "is not article author" do
        it "does not update" do
          put_update
          expect(Article.find(article.id).title).not_to eq("Anna")
        end
      end
    end
    context "user not signed in" do
      it "redirects to login page" do
        expect(put_update).to redirect_to new_user_session_path
      end
    end
    context "article part of publication" do
      context "members of publication" do
        context "if author of article" do
          it "it should update" do
            sign_in user
            @new_publication = create(:publication)
            @new_user_publication = create(:user_publication, email: user.email, publication_id: @new_publication.id)
            @article = create(:article, publication_id: @new_publication.id, user_id: @new_user_publication.user_id )
            expect(put :update, params: {id: @article, article: attributes_for(:article, title: "Anna")}).to redirect_to(@article)
          end
        end
        context "if not author" do
          it "it shouldn't update" do
            new_user = create(:user)
            sign_in user
            @new_publication = create(:publication)
            @new_user_publication = create(:user_publication, email: user.email, publication_id: @new_publication.id)
            @article = create(:article, publication_id: @new_publication.id, user_id: new_user.id )
            expect(put :update, params: {id: @article, article: attributes_for(:article, title: "Anna")}).not_to render_template(:edit)
          end
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "user signed in" do
      before(:example) do
        sign_in user
      end
      context "if user is author" do
        it "should delete the article" do
          new_article = create(:article, user_id: user.id)
          expect{
            delete :destroy, params: {id: new_article}
          }.to change(Article, :count).by(-1)
        end
        it "should go to root path" do
          new_article = create(:article, user_id: user.id)
          expect(delete :destroy, params: {id: new_article}).to redirect_to root_path
        end
      end
      context "if user is not author" do
        it "should not delete" do
          new_article = create(:article)
          expect{
            delete :destroy, params: {id: new_article}
          }.to change(Article, :count).by(0)
        end
      end
      context "article part of publication" do
        context "members of publication" do
          context "if author of article" do
            it "it deletes article" do
              sign_in user
              @new_publication = create(:publication)
              @new_user_publication = create(:user_publication, email: user.email, publication_id: @new_publication.id)
              @article = create(:article, publication_id: @new_publication.id, user_id: user.id )
              expect{
                delete :destroy, params: {id: @article}
              }.to change(Article, :count).by(-1)
            end
          end
          context "if not author" do
            it "it shouldn't delete" do
              new_user = create(:user)
              sign_in user
              @new_publication = create(:publication)
              @new_user_publication = create(:user_publication, email: user.email, publication_id: @new_publication.id)
              @article = create(:article, publication_id: @new_publication.id, user_id: new_user.id )
              expect{
                delete :destroy, params: {id: @article}
              }.to change(Article, :count).by(0)
            end
          end
        end
      end
    end
    context "not signed in" do
      it "redirects to login page" do
        expect(delete :destroy, params: {id: article}).to redirect_to new_user_session_path
      end
    end

  end
end
