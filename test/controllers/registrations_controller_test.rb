require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest

  test "should render new registration page" do
    get new_registration_path
    assert_response :success
    assert_select "form[action=?]", registration_path
  end

  test "users can sign up and session is created for them" do
    user_params = {
      email_address: "tuva@mail.com",
      password: "password",
      password_confirmation: "password",
    }

    assert_difference "User.count", 1 do
      post registration_path, params: { user: user_params }
    end

    assert cookies["session_id"], "User should be logged in after signing up"
    assert_redirected_to dashboard_path
  end
end
