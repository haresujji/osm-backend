require 'test_helper'

class OsmIssueHdrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @osm_issue_hdr = osm_issue_hdrs(:one)
  end

  test "should get index" do
    get osm_issue_hdrs_url
    assert_response :success
  end

  test "should get new" do
    get new_osm_issue_hdr_url
    assert_response :success
  end

  test "should create osm_issue_hdr" do
    assert_difference('OsmIssueHdr.count') do
      post osm_issue_hdrs_url, params: { osm_issue_hdr: {  } }
    end

    assert_redirected_to osm_issue_hdr_url(OsmIssueHdr.last)
  end

  test "should show osm_issue_hdr" do
    get osm_issue_hdr_url(@osm_issue_hdr)
    assert_response :success
  end

  test "should get edit" do
    get edit_osm_issue_hdr_url(@osm_issue_hdr)
    assert_response :success
  end

  test "should update osm_issue_hdr" do
    patch osm_issue_hdr_url(@osm_issue_hdr), params: { osm_issue_hdr: {  } }
    assert_redirected_to osm_issue_hdr_url(@osm_issue_hdr)
  end

  test "should destroy osm_issue_hdr" do
    assert_difference('OsmIssueHdr.count', -1) do
      delete osm_issue_hdr_url(@osm_issue_hdr)
    end

    assert_redirected_to osm_issue_hdrs_url
  end
end
