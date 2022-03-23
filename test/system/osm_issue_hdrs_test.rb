require "application_system_test_case"

class OsmIssueHdrsTest < ApplicationSystemTestCase
  setup do
    @osm_issue_hdr = osm_issue_hdrs(:one)
  end

  test "visiting the index" do
    visit osm_issue_hdrs_url
    assert_selector "h1", text: "Osm Issue Hdrs"
  end

  test "creating a Osm issue hdr" do
    visit osm_issue_hdrs_url
    click_on "New Osm Issue Hdr"

    click_on "Create Osm issue hdr"

    assert_text "Osm issue hdr was successfully created"
    click_on "Back"
  end

  test "updating a Osm issue hdr" do
    visit osm_issue_hdrs_url
    click_on "Edit", match: :first

    click_on "Update Osm issue hdr"

    assert_text "Osm issue hdr was successfully updated"
    click_on "Back"
  end

  test "destroying a Osm issue hdr" do
    visit osm_issue_hdrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Osm issue hdr was successfully destroyed"
  end
end
