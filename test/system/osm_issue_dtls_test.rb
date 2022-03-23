require "application_system_test_case"

class OsmIssueDtlsTest < ApplicationSystemTestCase
  setup do
    @osm_issue_dtl = osm_issue_dtls(:one)
  end

  test "visiting the index" do
    visit osm_issue_dtls_url
    assert_selector "h1", text: "Osm Issue Dtls"
  end

  test "creating a Osm issue dtl" do
    visit osm_issue_dtls_url
    click_on "New Osm Issue Dtl"

    click_on "Create Osm issue dtl"

    assert_text "Osm issue dtl was successfully created"
    click_on "Back"
  end

  test "updating a Osm issue dtl" do
    visit osm_issue_dtls_url
    click_on "Edit", match: :first

    click_on "Update Osm issue dtl"

    assert_text "Osm issue dtl was successfully updated"
    click_on "Back"
  end

  test "destroying a Osm issue dtl" do
    visit osm_issue_dtls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Osm issue dtl was successfully destroyed"
  end
end
