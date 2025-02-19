require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should redirect to login if not authenticated" do
    get profile_path
    assert_redirected_to new_session_path # Ensure unauthenticated users are redirected
  end

  test "should get show for logged-in user" do
    sign_in(users(:one))
    get profile_path
    assert_response :success
  end

  private

  def sign_in(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
  end
end
