require "test_helper"

class BorrowingRecordsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:one)
    @book = books(:one)
    @book_copy = @book.book_copies.first
    sign_in @user
  end

  test "should allow user to borrow a book" do
    assert_difference("BorrowingRecord.count", 1) do
      post borrowing_records_path, params: { book_copy_id: @book_copy.id }
    end
    assert_redirected_to book_path(@book)
  end

  test "should allow user to return a borrowed book" do
    borrowing = BorrowingRecord.create!(user: @user, book_copy: @book_copy, borrowed_at: Time.current)

    patch borrowing_record_path(borrowing)
    assert_redirected_to book_path(@book)
    borrowing.reload
    assert_not_nil borrowing.returned_at, "Returned book should have a returned date"

  end


  private

  def sign_in(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
  end
end
