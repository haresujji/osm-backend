require "application_system_test_case"

class TrnSfgStocksTest < ApplicationSystemTestCase
  setup do
    @trn_sfg_stock = trn_sfg_stocks(:one)
  end

  test "visiting the index" do
    visit trn_sfg_stocks_url
    assert_selector "h1", text: "Trn Sfg Stocks"
  end

  test "creating a Trn sfg stock" do
    visit trn_sfg_stocks_url
    click_on "New Trn Sfg Stock"

    click_on "Create Trn sfg stock"

    assert_text "Trn sfg stock was successfully created"
    click_on "Back"
  end

  test "updating a Trn sfg stock" do
    visit trn_sfg_stocks_url
    click_on "Edit", match: :first

    click_on "Update Trn sfg stock"

    assert_text "Trn sfg stock was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn sfg stock" do
    visit trn_sfg_stocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn sfg stock was successfully destroyed"
  end
end
