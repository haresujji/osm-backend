require 'test_helper'

class TransportMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transport_master = transport_masters(:one)
  end

  test "should get index" do
    get transport_masters_url, as: :json
    assert_response :success
  end

  test "should create transport_master" do
    assert_difference('TransportMaster.count') do
      post transport_masters_url, params: { transport_master: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show transport_master" do
    get transport_master_url(@transport_master), as: :json
    assert_response :success
  end

  test "should update transport_master" do
    patch transport_master_url(@transport_master), params: { transport_master: {  } }, as: :json
    assert_response 200
  end

  test "should destroy transport_master" do
    assert_difference('TransportMaster.count', -1) do
      delete transport_master_url(@transport_master), as: :json
    end

    assert_response 204
  end
end
