require 'rails_helper'

RSpec.describe GuessesController, type: :controller do

  describe "POST #create" do
    it "fails with a nonexistent game" do
      expect { post :create, game_id: 1 }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
