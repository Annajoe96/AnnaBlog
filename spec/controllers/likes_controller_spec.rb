require 'rails_helper'

RSpec.describe LikesController do
  #Factories
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:like) { create(:like) }

  #Methods

  def post_create
    post :create, params: {user_id: user, article_id: article}
  end

  def delete_destroy
    delete :destroy, params: {article_id: like.article.id , id: like.id}
  end

  describe "POST create" do

    context "signed in user" do
      before(:example) do
        sign_in user
      end
      context "create a like for article" do
        it "should create a like" do
          expect{
            post_create
          }.to change(Like, :count).by(1)
        end
      end
    end

    context "signed out user" do
      it "should not create like" do
        expect{
          post :create, params: {user_id: user, article_id: article}
        }.to change(Like, :count).by(0)
      end
    end
  end

  describe "DELETE_destroy" do
    context "user signed in" do
      before(:example) do
        sign_in user
      end
      context "user is not liker" do
        it "should not delete like " do
          new_like = create(:like)
          expect{
            delete :destroy, params: {article_id: new_like.article.id, id: new_like.id}
          }.to change(Like, :count).by(0)
        end
      end
      context "user is liker" do
        it "should delete like " do
          new_like = create(:like, user_id: user.id)
          expect{
            delete :destroy, params: {article_id: new_like.article.id, id: new_like.id}
          }.to change(Like, :count).by(-1)
        end
      end
    end
    context "user signed out" do
      it "should not delete like" do
        new_like = create(:like)
        expect{
          delete :destroy, params: {article_id: new_like.article.id, id: new_like.id}
        }.to change(Like, :count).by(0)
      end
    end
  end

end
