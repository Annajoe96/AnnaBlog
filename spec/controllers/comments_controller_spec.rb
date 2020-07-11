require 'rails_helper'

RSpec.describe CommentsController do

  #Factories
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:comment) { create(:comment) }

  #Methods
  def post_create
    post :create, params: {user_id: user, article_id: article, comment: attributes_for(:comment)}
  end

  def delete_destroy
    delete :destroy, params: {article_id: comment.article.id , id: comment.id}
  end

  describe "POST create" do
    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "with valid attributes" do
        it "should create a comment" do
          expect{
            post_create
          }.to change(article.comments, :count).by(1)
        end
      end
      context "with nil attribute" do
        it "should render same page" do
          expect(post_create).to redirect_to(assigns(:article))
        end
        it "should not add comment" do
          expect{
            post :create, params: {user_id: user, article_id: article, comment: attributes_for(:comment, comment: nil)}
          }.to change(Comment, :count).by(0)
        end
      end
    end
    context "signed out user" do
      it "should redirect to user sign up " do
        expect(post_create).to redirect_to new_user_session_path
      end
      it "should not create comment" do
        expect{
          post_create
        }.to change(Comment, :count).by(0)
      end
    end
  end

  describe "DELETE_destroy" do
    context "signed_in user" do
      before(:example) do
        sign_in user
      end
      context "when commenter deletes" do
        it "should delete" do
          new_comment = create(:comment, user_id: user.id)
          expect {
            delete :destroy, params: {article_id: new_comment.article.id, id: new_comment.id}
          }.to change(Comment, :count).by(-1)
        end
      end
      context "when author deletes" do
        it "should delete" do
          new_article = create(:article, user_id: user.id)
          comment_user = create(:user)
          new_comment = create(:comment, user_id: comment_user.id, article_id: new_article.id)
          expect {
            delete :destroy, params: {article_id: new_comment.article.id, id: new_comment.id}
          }.to change(Comment, :count).by(-1)
        end
      end
      context "when non commenter/ non author deletes" do
        it "should not delete" do
          new_comment = create(:comment)
          expect{
            delete :destroy, params: {article_id: new_comment.article.id, id: new_comment.id}
          }.to change(Comment, :count).by(0)
        end
      end
    end
    context "signed_out user" do
      it "it should not delete" do
        expect{
          delete_destroy
        }.to change(Comment, :count).by(0)
      end
    end

  end




end
