require 'rails_helper'

RSpec.describe GamesHelper, type: :helper do
  let(:game) { instance_double(Game, guessed_letters: guessed_letters) }

  describe "#valid_guesses" do
    subject { helper.valid_guesses(game) }

    context "when no letters have been guessed" do
      let(:guessed_letters) { [] }
      it { is_expected.to eq ("a".."z").to_a }
    end

    context "when one letter has been guessed" do
      let(:guessed_letters) { ["a"] }
      it { is_expected.not_to include "a" }
      it { is_expected.to eq ("b".."z").to_a }
    end

    context "when all letters have been guessed" do
      let(:guessed_letters) { ("a".."z").to_a }
      it { is_expected.to be_empty }
    end
  end

end
