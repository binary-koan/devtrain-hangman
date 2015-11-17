require 'rails_helper'

RSpec.feature "Game creation", type: :feature do

  scenario "Creating a game" do
    visit "/games/new"
    click_button "New game"

    expect(page).to have_text /Game [0-9]+/
  end

end
