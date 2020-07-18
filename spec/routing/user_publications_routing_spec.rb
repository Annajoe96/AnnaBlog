require "rails_helper"

RSpec.describe UserPublicationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_publications").to route_to("user_publications#index")
    end

    it "routes to #new" do
      expect(get: "/user_publications/new").to route_to("user_publications#new")
    end

    it "routes to #show" do
      expect(get: "/user_publications/1").to route_to("user_publications#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_publications/1/edit").to route_to("user_publications#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_publications").to route_to("user_publications#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_publications/1").to route_to("user_publications#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_publications/1").to route_to("user_publications#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_publications/1").to route_to("user_publications#destroy", id: "1")
    end
  end
end
