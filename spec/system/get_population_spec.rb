require 'rails_helper'

RSpec.describe "Get population by year", type: :system do
  it "User is presented with an input form" do
    visit populations_path
    assert_selector "input[name=year]"
    assert_selector "button[type=submit]"
  end

  it "results are displayed on index page" do
    visit populations_path

    fill_in "year", with: "1908"
    click_on "Submit"

    assert_selector "div#results"

    expect(page).to have_text("1908")
  end

  describe "When user enters a valid year" do
    it "redirects to a results page"
    it "shows a population figure"
  end
end
