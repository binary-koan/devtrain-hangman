require 'rails_helper'

RSpec.describe GuessesController, type: :controller do

  describe "POST #create" do
    it "fails with a nonexistent game" do
      expect { post :create, game_id: 1 }.to raise_error ActiveRecord::RecordNotFound
    end

    context "with a valid game" do
      let(:game) { Game.create! }

      it "succeeds with a valid guess" do
        post :create, game_id: game.id, guess: { guessed_letter: "a" }
        expect(flash.alert).to be_nil
        expect(response).to redirect_to "/games/#{game.id}"
      end

      it "fails with an invalid guess" do
        post :create, game_id: game.id, guess: { guessed_letter: "ab" }
        expect(flash.alert).to include "Guessed letter must be one lowercase letter"
        expect(response).to redirect_to "/games/#{game.id}"
      end
    end
  end

end
