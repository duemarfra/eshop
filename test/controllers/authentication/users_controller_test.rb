require "test_helper"

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: {
                        email: "test1@test.com",
                        username: "test1",
                        password: "abc123",
                      } }
    end

    assert_redirected_to items_url
  end
end
