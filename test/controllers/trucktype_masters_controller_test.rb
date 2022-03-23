require 'test_helper'

class TrucktypeMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trucktype_master = trucktype_masters(:one)
  end

  test "should get index" do
    get trucktype_masters_url, as: :json
    assert_response :success
  end

  test "should create trucktype_master" do
    assert_difference('TrucktypeMaster.count') do
      post trucktype_masters_url, params: { trucktype_master: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show trucktype_master" do
    get trucktype_master_url(@trucktype_master), as: :json
    assert_response :success
  end

  test "should update trucktype_master" do
    patch trucktype_master_url(@trucktype_master), params: { trucktype_master: {  } }, as: :json
    assert_response 200
  end

  test "should destroy trucktype_master" do
    assert_difference('TrucktypeMaster.count', -1) do
      delete trucktype_master_url(@trucktype_master), as: :json
    end

    assert_response 204
  end
end
