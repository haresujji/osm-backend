require 'test_helper'

class LoginsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @login = logins(:one)
  end

  test "should get index" do
    get logins_url, as: :json
    assert_response :success
  end

  test "should create login" do
    assert_difference('Login.count') do
      post logins_url, params: { login: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show login" do
    get login_url(@login), as: :json
    assert_response :success
  end

  test "should update login" do
    patch login_url(@login), params: { login: {  } }, as: :json
    assert_response 200
  end

  test "should destroy login" do
    assert_difference('Login.count', -1) do
      delete login_url(@login), as: :json
    end

    assert_response 204
  end
end
