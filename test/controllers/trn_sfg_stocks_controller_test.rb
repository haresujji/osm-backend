require 'test_helper'

class TrnSfgStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_sfg_stock = trn_sfg_stocks(:one)
  end

  test "should get index" do
    get trn_sfg_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_sfg_stock_url
    assert_response :success
  end

  test "should create trn_sfg_stock" do
    assert_difference('TrnSfgStock.count') do
      post trn_sfg_stocks_url, params: { trn_sfg_stock: {  } }
    end

    assert_redirected_to trn_sfg_stock_url(TrnSfgStock.last)
  end

  test "should show trn_sfg_stock" do
    get trn_sfg_stock_url(@trn_sfg_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_sfg_stock_url(@trn_sfg_stock)
    assert_response :success
  end

  test "should update trn_sfg_stock" do
    patch trn_sfg_stock_url(@trn_sfg_stock), params: { trn_sfg_stock: {  } }
    assert_redirected_to trn_sfg_stock_url(@trn_sfg_stock)
  end

  test "should destroy trn_sfg_stock" do
    assert_difference('TrnSfgStock.count', -1) do
      delete trn_sfg_stock_url(@trn_sfg_stock)
    end

    assert_redirected_to trn_sfg_stocks_url
  end
end
