require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @book = books(:one)
    sign_in users(:one)
  end


  test "should get index" do
    get books_path
    assert_response :success
  end

  test "should get show" do
    get book_path(@book)
    assert_response :success
  end

  test "should return 404 if book not found" do
    get book_path(id: 6868)
    assert_response :not_found
  end

  private

  def sign_in(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
  end
end
