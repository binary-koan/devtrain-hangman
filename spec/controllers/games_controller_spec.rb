require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "redirects to the new game" do
      post :create
      expect(response).to redirect_to(action: :show, id: assigns(:game).id)
    end
  end

  describe "GET #show" do
    it "fails for a game which does not exist" do
      get :show, id: 1
      expect(response).to have_http_status(404)
    end
  end

end
