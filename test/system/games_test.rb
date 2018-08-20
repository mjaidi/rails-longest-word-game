require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 9
  end

  test "word that doesn't exist" do
    visit new_url
    fill_in "word", with: "gibsdf"
    click_on "Guess"

    assert_selector "h3", text: "The given word is not an english word"
  end
end
