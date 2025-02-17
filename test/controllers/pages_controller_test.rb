require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest

  test "unauthenticated users accessing home should see home page" do
    get root_path
    assert_response :success, "Unauthenticated users should see home page"
  end

  test "authenticated users accessing home should be redirected to dashboard page" do
    sign_in users(:one)
    get root_path
    assert_redirected_to dashboard_path, "Authenticated users be redirected to dashboard page"
  end

  test "unauthenticated users accessing dashboard should be redirected to login page" do
    get dashboard_path
    assert_redirected_to new_session_path
  end

  test "authenticated users should be able to access dashboard" do
    sign_in users(:one)
    get dashboard_path
    assert_response :success
  end


  private

  def sign_in(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
  end
end
