require 'rails_helper'

RSpec.describe "XSS Attack Attempt", type: :system do
  it "Results page sanitizes value of year" do
    visit populations_path

    fill_in "year", with: "\"><script>alert(\"XSS\")</script>&"
    click_button "Submit"

    expect(page).to have_text("\">alert(\"XSS\")&")

  end

end
