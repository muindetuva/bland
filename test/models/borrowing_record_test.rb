require "test_helper"

class BorrowingRecordTest < ActiveSupport::TestCase

  # Rails already enforces under the hood presence validation but leaving the test here
  test "should not save borrowing record without a user" do
    record = BorrowingRecord.new(book: books(:one), borrowed_at: Time.current)

    assert_not record.valid?, "BorrowingRecord should have user_id"
  end

  # Rails already enforces under the hood presence validation but leaving the test here
  test "should not save borrowing record without a book" do
    record = BorrowingRecord.new(user: users(:one), borrowed_at: Time.current)

    assert_not record.valid?, "BorrowingRecord should have book_id"
  end

  test "should not save borrowing record without a borrowed_at date" do
    record = BorrowingRecord.new(user:users(:one), book: books(:one))

    assert_not record.valid?, "BorrowingRecord should have borrowed_at date"
  end


  test "should set due_date ot 2 weeks from borrowed_at" do
    record = BorrowingRecord.new(user:users(:one), book: books(:one), borrowed_at: Time.current)
    record.valid?
    assert_not_nil record.due_date, "Due date should not be nill"
    assert_equal 2.weeks.from_now.to_date, record.due_date.to_date, "Due date should be two weeks from borrowed_at"
  end

  test "should not allow returned at to be null after book is returned" do
    record = BorrowingRecord.create!(user: users(:one), book: books(:one), borrowed_at: Time.current)
    record.update!(returned_at: Time.current)

    assert_not_nil record.returned_at, "BorrowingRecord should have returned_at date after book is returned"
  end

  test "should not allow book to be borrowed twice" do
    BorrowingRecord.create!(user: users(:one), book: books(:one), borrowed_at: Time.current)
    second_borrowing_record = BorrowingRecord.new(user: users(:two), book: books(:one), borrowed_at: Time.current)

    assert_not second_borrowing_record.valid?, "Book should not be borrowable if already borrowed"
  end

  test "should not allow a user to borrow the same book twice without returning it" do
    BorrowingRecord.create!(user: users(:one), book: books(:one), borrowed_at: Time.current)
    second_borrowing_record = BorrowingRecord.new(user: users(:one), book: books(:one), borrowed_at: Time.current)

    assert_not second_borrowing_record.valid?, "User should not be able to borrow the same book again without returning it"
  end

  test "should allow a book to be borrowed again after it is returned" do
    record = BorrowingRecord.create!(user: users(:one), book: books(:one), borrowed_at: Time.current)
    record.update!(returned_at: Time.current)  # Return the book

    new_borrowing = BorrowingRecord.new(user: users(:one), book: books(:one), borrowed_at: Time.current)

    assert new_borrowing.valid?, "User should be able to borrow a book again after returning it"
  end

end
