require 'rails_helper'

RSpec.feature "Guessing" do
  let(:game) { Game.create!(target_word: "something") }
  before { visit "/games/#{game.id}" }

  scenario "guessing correctly" do
    select "i", from: "Guess"
    click_button "Guess"

    expect(page).to have_selector(:css, ".masked-word .letter:not(:empty)")
    expect(page).to have_text("i")
  end

  scenario "guessing incorrectly" do
    select "q", from: "Guess"
    click_button "Guess"

    expect(page).to have_text("You have made 1 incorrect guess: q")
  end

end
