require 'test_helper'

class TrnCheckListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_check_list = trn_check_lists(:one)
  end

  test "should get index" do
    get trn_check_lists_url, as: :json
    assert_response :success
  end

  test "should create trn_check_list" do
    assert_difference('TrnCheckList.count') do
      post trn_check_lists_url, params: { trn_check_list: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show trn_check_list" do
    get trn_check_list_url(@trn_check_list), as: :json
    assert_response :success
  end

  test "should update trn_check_list" do
    patch trn_check_list_url(@trn_check_list), params: { trn_check_list: {  } }, as: :json
    assert_response 200
  end

  test "should destroy trn_check_list" do
    assert_difference('TrnCheckList.count', -1) do
      delete trn_check_list_url(@trn_check_list), as: :json
    end

    assert_response 204
  end
end
