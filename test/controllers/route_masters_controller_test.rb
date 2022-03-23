require 'test_helper'

class RouteMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @route_master = route_masters(:one)
  end

  test "should get index" do
    get route_masters_url, as: :json
    assert_response :success
  end

  test "should create route_master" do
    assert_difference('RouteMaster.count') do
      post route_masters_url, params: { route_master: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show route_master" do
    get route_master_url(@route_master), as: :json
    assert_response :success
  end

  test "should update route_master" do
    patch route_master_url(@route_master), params: { route_master: {  } }, as: :json
    assert_response 200
  end

  test "should destroy route_master" do
    assert_difference('RouteMaster.count', -1) do
      delete route_master_url(@route_master), as: :json
    end

    assert_response 204
  end
end
