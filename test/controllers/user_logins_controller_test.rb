require 'test_helper'

class UserLoginsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_login = user_logins(:one)
  end

  test "should get index" do
    get user_logins_url, as: :json
    assert_response :success
  end

  test "should create user_login" do
    assert_difference('UserLogin.count') do
      post user_logins_url, params: { user_login: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_login" do
    get user_login_url(@user_login), as: :json
    assert_response :success
  end

  test "should update user_login" do
    patch user_login_url(@user_login), params: { user_login: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_login" do
    assert_difference('UserLogin.count', -1) do
      delete user_login_url(@user_login), as: :json
    end

    assert_response 204
  end
end
