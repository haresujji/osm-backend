require 'test_helper'

class OsmIssueDtlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @osm_issue_dtl = osm_issue_dtls(:one)
  end

  test "should get index" do
    get osm_issue_dtls_url
    assert_response :success
  end

  test "should get new" do
    get new_osm_issue_dtl_url
    assert_response :success
  end

  test "should create osm_issue_dtl" do
    assert_difference('OsmIssueDtl.count') do
      post osm_issue_dtls_url, params: { osm_issue_dtl: {  } }
    end

    assert_redirected_to osm_issue_dtl_url(OsmIssueDtl.last)
  end

  test "should show osm_issue_dtl" do
    get osm_issue_dtl_url(@osm_issue_dtl)
    assert_response :success
  end

  test "should get edit" do
    get edit_osm_issue_dtl_url(@osm_issue_dtl)
    assert_response :success
  end

  test "should update osm_issue_dtl" do
    patch osm_issue_dtl_url(@osm_issue_dtl), params: { osm_issue_dtl: {  } }
    assert_redirected_to osm_issue_dtl_url(@osm_issue_dtl)
  end

  test "should destroy osm_issue_dtl" do
    assert_difference('OsmIssueDtl.count', -1) do
      delete osm_issue_dtl_url(@osm_issue_dtl)
    end

    assert_redirected_to osm_issue_dtls_url
  end
end
