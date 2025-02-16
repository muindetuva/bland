require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "should not save user without email" do
    user = User.new(password: "password")
    assert_not user.valid?, "User can't be saved without an email"
  end

  test "should not save user without password" do
    user = User.new(email_address: "test@test.com")
    assert_not user.valid?, "User can't be saved without a password"
  end

  test "should not allow duplicate email_address" do
    User.create!(email_address: "test@test.com", password: "password")
    duplicate_user = User.new(email_address: "test@test.com", password: "password")

    assert_not duplicate_user.valid?, "Email has to be unique"
  end

end
