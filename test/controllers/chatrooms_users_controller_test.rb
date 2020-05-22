require 'test_helper'

class ChatroomsUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get chatrooms_users_create_url
    assert_response :success
  end

  test "should get destroy" do
    get chatrooms_users_destroy_url
    assert_response :success
  end

end
