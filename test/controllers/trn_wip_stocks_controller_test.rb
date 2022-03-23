require 'test_helper'

class TrnWipStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_wip_stock = trn_wip_stocks(:one)
  end

  test "should get index" do
    get trn_wip_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_wip_stock_url
    assert_response :success
  end

  test "should create trn_wip_stock" do
    assert_difference('TrnWipStock.count') do
      post trn_wip_stocks_url, params: { trn_wip_stock: {  } }
    end

    assert_redirected_to trn_wip_stock_url(TrnWipStock.last)
  end

  test "should show trn_wip_stock" do
    get trn_wip_stock_url(@trn_wip_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_wip_stock_url(@trn_wip_stock)
    assert_response :success
  end

  test "should update trn_wip_stock" do
    patch trn_wip_stock_url(@trn_wip_stock), params: { trn_wip_stock: {  } }
    assert_redirected_to trn_wip_stock_url(@trn_wip_stock)
  end

  test "should destroy trn_wip_stock" do
    assert_difference('TrnWipStock.count', -1) do
      delete trn_wip_stock_url(@trn_wip_stock)
    end

    assert_redirected_to trn_wip_stocks_url
  end
end
