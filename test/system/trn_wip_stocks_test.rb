require "application_system_test_case"

class TrnWipStocksTest < ApplicationSystemTestCase
  setup do
    @trn_wip_stock = trn_wip_stocks(:one)
  end

  test "visiting the index" do
    visit trn_wip_stocks_url
    assert_selector "h1", text: "Trn Wip Stocks"
  end

  test "creating a Trn wip stock" do
    visit trn_wip_stocks_url
    click_on "New Trn Wip Stock"

    click_on "Create Trn wip stock"

    assert_text "Trn wip stock was successfully created"
    click_on "Back"
  end

  test "updating a Trn wip stock" do
    visit trn_wip_stocks_url
    click_on "Edit", match: :first

    click_on "Update Trn wip stock"

    assert_text "Trn wip stock was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn wip stock" do
    visit trn_wip_stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn wip stock was successfully destroyed"
  end
end
