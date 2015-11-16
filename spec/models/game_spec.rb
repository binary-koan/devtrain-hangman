require 'rails_helper'

RSpec.describe Game, type: :model do
  subject(:game) { Game.new }

  describe "#target_word" do
    it "is generated on save" do
      game.save!
      expect(game.target_word).not_to be_nil
    end

    it "can be set explicitly" do
      game.target_word = "notactuallyaword"
      game.save!
      expect(game.target_word).to eq "notactuallyaword"
    end
  end
end
