require "test_helper"

class ProfessionalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get professionals_new_url
    assert_response :success
  end

  test "should get create" do
    get professionals_create_url
    assert_response :success
  end

  test "should get index" do
    get professionals_index_url
    assert_response :success
  end

  test "should get edit" do
    get professionals_edit_url
    assert_response :success
  end
end
