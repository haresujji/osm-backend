require 'test_helper'

class CheckListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @check_list = check_lists(:one)
  end

  test "should get index" do
    get check_lists_url, as: :json
    assert_response :success
  end

  test "should create check_list" do
    assert_difference('CheckList.count') do
      post check_lists_url, params: { check_list: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show check_list" do
    get check_list_url(@check_list), as: :json
    assert_response :success
  end

  test "should update check_list" do
    patch check_list_url(@check_list), params: { check_list: {  } }, as: :json
    assert_response 200
  end

  test "should destroy check_list" do
    assert_difference('CheckList.count', -1) do
      delete check_list_url(@check_list), as: :json
    end

    assert_response 204
  end
end
