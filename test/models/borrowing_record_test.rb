require "test_helper"

class BorrowingRecordTest < ActiveSupport::TestCase

  # Rails already enforces under the hood presence validation but leaving the test here
  test "should not save borrowing record without a user" do
    record = BorrowingRecord.new(book_copy: book_copies(:one), borrowed_at: Time.current)

    assert_not record.valid?, "BorrowingRecord should have user_id"
  end

  # Rails already enforces under the hood presence validation but leaving the test here
  test "should not save borrowing record without a book_copy" do
    record = BorrowingRecord.new(user: users(:one), borrowed_at: Time.current)

    assert_not record.valid?, "BorrowingRecord should have book_copy_id"
  end

  test "should not save borrowing record without a borrowed_at date" do
    record = BorrowingRecord.new(user:users(:one), book_copy: book_copies(:one))

    assert_not record.valid?, "BorrowingRecord should have borrowed_at date"
  end


  test "should set due_date ot 2 weeks from borrowed_at" do
    record = BorrowingRecord.new(user:users(:one), book_copy: book_copies(:one), borrowed_at: Time.current)
    record.valid?
    assert_not_nil record.due_date, "Due date should not be nill"
    assert_equal 2.weeks.from_now.to_date, record.due_date.to_date, "Due date should be two weeks from borrowed_at"
  end

  test "should not allow returned at to be null after book is returned" do
    record = BorrowingRecord.create!(user: users(:one), book_copy: book_copies(:one), borrowed_at: Time.current)
    record.update!(returned_at: Time.current)

    assert_not_nil record.returned_at, "BorrowingRecord should have returned_at date after book is returned"
  end

  test "should not allow book_copy to be borrowed twice" do
    BorrowingRecord.create!(user: users(:one), book_copy: book_copies(:one), borrowed_at: Time.current)
    second_borrowing_record = BorrowingRecord.new(user: users(:two), book_copy: book_copies(:one), borrowed_at: Time.current)

    assert_not second_borrowing_record.valid?, "Book should not be borrowable if already borrowed"
  end

  test "should allow a book to be borrowed again after it is returned" do
    record = BorrowingRecord.create!(user: users(:one), book_copy: book_copies(:one), borrowed_at: Time.current)
    record.update!(returned_at: Time.current)  # Return the book

    new_borrowing = BorrowingRecord.new(user: users(:one), book_copy: book_copies(:one), borrowed_at: Time.current)

    assert new_borrowing.valid?, "User should be able to borrow a book again after returning it"
  end

  test "should allow different users to borrow different copies of the same book" do
    copy1 = book_copies(:one)   # book(:one)
    copy2 = book_copies(:three) # also book(:one)

    BorrowingRecord.create!(user: users(:one), book_copy: copy1, borrowed_at: Time.current)
    second_borrowing_record = BorrowingRecord.new(user: users(:two), book_copy: copy2, borrowed_at: Time.current)

    assert second_borrowing_record.valid?, "Different users should be able to borrow different copies of the same book"
  end

end
