require "test_helper"

class Public::ContributorsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_contributors_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_contributors_update_url
    assert_response :success
  end
end
