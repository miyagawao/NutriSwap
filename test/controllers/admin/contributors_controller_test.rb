require "test_helper"

class Admin::ContributorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_contributors_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_contributors_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_contributors_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_contributors_update_url
    assert_response :success
  end
end
